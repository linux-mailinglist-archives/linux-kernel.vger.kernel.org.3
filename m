Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACA50E4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbiDYP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiDYP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:59:19 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A575E3FBF8;
        Mon, 25 Apr 2022 08:56:15 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id f13-20020a4aa68d000000b0033a2c53d0baso2872004oom.0;
        Mon, 25 Apr 2022 08:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Keqz+An68JFJoxGJpxJgcEsiVu09q9HsfX88H2vT/Hs=;
        b=0j095FHTFpAZjkZrsNz4z8gPuOyntHQdy7F3Est2c690Y9An4fckH8lUbiSq8VWhu9
         BmOn0o/OuBlkXl5od/TVpgLWRUYwTpjXCd5e5rPLdIxZUxengQPWcyO9LG3DKkBF0CMV
         GI/5IHzzN+Tv3fJHWLVAUjO7TvSBkuVczsVjL53LTDsf/2WEu5SLKgjBAUEwdwJryq4g
         9A3VHW8kHKvuygHMkgN9+oJEPo33Rs94XoPXLJmT+HkX/T0L3gIaTOd2gyHw2ChAeV6A
         DeMt5fOWa975S7+uk3M4FhMaG4DuDahPCDmC+/OTd2uGjgcxHVDh/YXu59pe4mJpYE/J
         pkUw==
X-Gm-Message-State: AOAM531HwZdMJlNhTX0v+G9UOD5zbMs5AeexDr6tVD9H3313y0w+t9mB
        p9DesbKZGZtwaagRUxjeHA==
X-Google-Smtp-Source: ABdhPJznQ8C2Rt9OEFAObU32Vgd+lYQoJcQox9kfvmE+P+WF1kE1eMz1m9UOW8O0fWdO7BdxStQpew==
X-Received: by 2002:a4a:b3c5:0:b0:324:527f:8709 with SMTP id q5-20020a4ab3c5000000b00324527f8709mr6637977ooo.90.1650902174750;
        Mon, 25 Apr 2022 08:56:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 6-20020a9d0006000000b0060152dd63a6sm3863297ota.55.2022.04.25.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:56:14 -0700 (PDT)
Received: (nullmailer pid 3956552 invoked by uid 1000);
        Mon, 25 Apr 2022 15:56:13 -0000
Date:   Mon, 25 Apr 2022 10:56:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        pantelis.antoniou@konsulko.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: Re: [PATCH v4 2/2] of: overlay: rework overlay apply and remove
 kfree()s
Message-ID: <YmbEneH6PrPxAj4u@robh.at.kernel.org>
References: <20220420222505.928492-1-frowand.list@gmail.com>
 <20220420222505.928492-3-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420222505.928492-3-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 17:25:05 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Fix various kfree() issues related to of_overlay_apply().
>   - Double kfree() of fdt and tree when init_overlay_changeset()
>     returns an error.
>   - free_overlay_changeset() free the root of the unflattened
>     overlay (variable tree) instead of the memory that contains
>     the unflattened overlay.
>   - For the case of a failure during applying an overlay, move kfree()
>     of new_fdt and overlay_mem into free_overlay_changeset(), which
>     is called by the function that allocated them.
>   - For the case of removing an overlay, the kfree() of new_fdt and
>     overlay_mem remains in free_overlay_changeset().
>   - Check return value of of_fdt_unflatten_tree() for error instead
>     of checking the returned value of overlay_root.
>   - When storing pointers to allocated objects in ovcs, do so as
>     near to the allocation as possible instead of in deeply layered
>     function.
> 
> More clearly document policy related to lifetime of pointers into
> overlay memory.
> 
> Double kfree()
> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> ---
> 
> Chose value of zero for OF_OVERLAY_INIT instead of -1, so that the
> value of ovcs->notify_state would be properly initialed by the
> kzalloc() of ovcs.
> 
> My first reply to this email will be a diff of this patch vs
> v3 of this patch.
> 
> Changes since v3:
>    - Instead of field kfree_unsafe in struct overlay_changeset, add
>      field notify_state to track action of most recent notification,
>      allowing the free_overlay_changeset() code to choose whether
>      to free overlay_mem and new_fdt.
>    - Add new value OF_OVERLAY_INIT to enum of_overlay_notify_action
> 
> Changes since v2:
>   - A version 2 review comment correctly said "This screams hack".
>     Restructure as listed below in response to the comment.
>   - Quit passing kfree_unsafe in function parameters, move it to
>     be a field of ovcs
>   - Quit passing a bunch of objects as function parameters, which
>     were used only for saving in ovcs
>   - Save pointers to allocated objects as near to the allocation as
>     possible instead of in a different function.
>   - Move object allocation as early in the calling stack (starting
>     at of_overlay_fdt_apply()) and move object freeing more fully
>     into free_overlay_changeset(), which is called in two places:
>     (1) on error path of applying overlay and (2) removal of an
>     overlay by of_overlay_remove().
>   - Additional notes in the overlay documentation regarding pointers
>     into overlay nodes and data.
> 
> Changes since v1:
>   - Move kfree()s from init_overlay_changeset() to of_overlay_fdt_apply()
>   - Better document lifetime of pointers into overlay, both in overlay.c
>     and Documentation/devicetree/overlay-notes.rst
> 
>  Documentation/devicetree/overlay-notes.rst |  30 ++-
>  drivers/of/overlay.c                       | 263 ++++++++++-----------
>  include/linux/of.h                         |   3 +-
>  3 files changed, 153 insertions(+), 143 deletions(-)
> 

Applied, thanks!
