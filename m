Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEDD517B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiECBQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiECBPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:15:54 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A6E0B;
        Mon,  2 May 2022 18:12:22 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e5ca5c580fso15924979fac.3;
        Mon, 02 May 2022 18:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5c3nAib//d7xQj9e0trcxqkLomABnHAZMncp89e42Vk=;
        b=RzPe4mW6UvjsWb8wB2rnP6OM7EFkyN2oIZxAZ9gfvYBnfZ15lH96wxf2oqSwAEojU/
         1964ARH6fUomxY+udKQ71of4k4aoMceb6J7RPePU++wyYxBCkwIVVmPYwbFPApyDbhxL
         TkCEqvCUq8QWF2f5QMuXOE29y3FvjOkQbuTk44+AazstrV6i4bKhfMNwXH1a03TGTLMH
         vS6atRJhUJ9fK7P2f96z8Vd4dGnNr6HxRFUyg0G/7TLwypei+eabQXlD8UGt9SwAM6zP
         i1RXmMcMpZkzfMcIBeNZHdQZYgJZNXc1czHboiBEjwU8QFvYtj0/9ZAAqzEdVGPrAIgj
         DUcA==
X-Gm-Message-State: AOAM5315j+7kt7ke0Es4YdD7QLe+EYgdjO+28pPSLEKjQfYYloMiojfW
        EMEXLVS/dSSiYZIFmdCItzl5pqcvBw==
X-Google-Smtp-Source: ABdhPJx+ieV44C6Sc1L8qds7KFaA1+S433NOiO+oyUItpFP/Y6bCudwTRDB/qJEY8XUvWl81tJHDnw==
X-Received: by 2002:a05:6870:434d:b0:e5:9115:cb15 with SMTP id x13-20020a056870434d00b000e59115cb15mr841105oah.53.1651539548285;
        Mon, 02 May 2022 17:59:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m63-20020aca5842000000b00325cda1ff9esm2892865oib.29.2022.05.02.17.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:59:07 -0700 (PDT)
Received: (nullmailer pid 2159671 invoked by uid 1000);
        Tue, 03 May 2022 00:59:07 -0000
Date:   Mon, 2 May 2022 19:59:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Slawomir Stepien <slawomir.stepien@nokia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org, Slawomir Stepien <sst@poczta.fm>,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 3/3] of: overlay: do not free changeset when
 of_overlay_apply returns error
Message-ID: <YnB+W6u5dL44vEBL@robh.at.kernel.org>
References: <20220502181742.1402826-1-frowand.list@gmail.com>
 <20220502181742.1402826-4-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502181742.1402826-4-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2022 13:17:42 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> New unittests for overlay notifiers reveal a memory leak in
> of_overlay_apply() when a notifier returns an error for action
> OF_OVERLAY_POST_APPLY.  The pr_err() message is:
> 
>    OF: ERROR: memory leak, expected refcount 1 instead of 3,
>    of_node_get()/of_node_put() unbalanced - destroy cset entry: attach
>    overlay node /testcase-data/overlay-node/test-bus/test-unittest17
> 
> Change the error path to no longer call free_overlay_changeset(),
> and document that the caller of of_overlay_fdt_apply() may choose
> to remove the overlay.
> 
> Update the unittest that triggered the error to expect the changed
> return values and to call of_overlay_remove().
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since version 1:
>   - patch 1/1 v1 did not apply on Rob's dt/next branch, rebase on top of
>     5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}
> 
> Output of the new overlay notifier unittests, as filtered by
> scripts/dtc/of_unittest_expect:
> 
>    ### dt-test ### pass of_unittest_overlay_notify():2825
> ok OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2846
>    ### dt-test ### pass of_unittest_overlay_notify():2851
> ok OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2857
>    ### dt-test ### pass of_unittest_overlay_notify():2862
>    ### dt-test ### pass of_unittest_overlay_notify():2866
>    ### dt-test ### pass of_unittest_overlay_notify():2872
>    ### dt-test ### pass of_unittest_overlay_notify():2875
> ok OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2886
>    ### dt-test ### pass of_unittest_overlay_notify():2894
>    ### dt-test ### pass of_unittest_overlay_notify():2898
>    ### dt-test ### pass of_unittest_overlay_notify():2901
> ok OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus
>    ### dt-test ### pass of_unittest_overlay_notify():2908
>    ### dt-test ### pass of_unittest_overlay_notify():2915
>    ### dt-test ### pass of_unittest_overlay_notify():2920
>    ### dt-test ### pass of_unittest_overlay_notify():2932
> 
> 
>  drivers/of/overlay.c  | 29 ++++++++++++++++++++++++++---
>  drivers/of/unittest.c | 10 ++++++++--
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 

Applied, thanks!
