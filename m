Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065A35A02E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbiHXUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiHXUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:36:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C354673;
        Wed, 24 Aug 2022 13:36:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y187so14382325iof.0;
        Wed, 24 Aug 2022 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o/Asl1a05iqi7M0+s6lqc9+F54rnbn8OzEyUZOMsiEo=;
        b=ACOE4tdbDMngehxmTvG7PfhPyErgshLWF2bCW4RnDsuQ7be+urtFNkb26DfVKfZ3PT
         AgCY5atQiy/sHku6wYUM4pmUgguac4Vj8HEsGyYBoI6maLLs4fWCraooOpRze+S7+wFs
         c/LpcvOzINAL199TDGIyj3RkX/+ovAWsl3MLZ6ByLTZrI94wy28EoxKN1w86wiK27ZJz
         AzRB2/8Usba3V1eDyfy/jyVJXUHSBeyRRvPtjxZzQ12BfoNs1IvD/0EawRvNrOthyeqA
         y5HAMp6O6awJ3tgJcOsgGjUaCWcipQcsMrbLpgKBqQEndD32gtdBUP9M91U/8lb/BBjb
         2M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o/Asl1a05iqi7M0+s6lqc9+F54rnbn8OzEyUZOMsiEo=;
        b=GEFP0asRjydd0YrYxdrCFS1f1sm/uDzFGfnVreJCfb04v3vpXOemAvMRab9VcIz9T3
         uf98cZgPt1QH+rkbrYrXWk8S+AJF6Vo1wF2S+aSDEMoutvdKNAVu+bAmvXs9bGeRWwkQ
         S3bVqb2Xa8mJeJg/cPhBeOwIPRpP9pdRcChwEnTZmdQGNGa6cROfltfSxXVc4khNoFJ2
         9SZmYV3dYVn9fD1PRQyUOvaxKarkyYRvUx148rHRmWhc7XG8hA5N2d/Ak3yu42cEnX/t
         +bKz7CIw9PA0G1vwhjZMvK+4Qd3dT1FRVCbamNqNSHP5PXl/Rkf/Wx5wrVPeYIJc5kAK
         PB4A==
X-Gm-Message-State: ACgBeo2tGOM3rpYswGkfvEOzcxTQnbJneuptIX1mnMkx0i0A1rvA1oj5
        Oek3NYNAtpE5+MNHAi3Xh9vFLGyDRDtORfcD4cs=
X-Google-Smtp-Source: AA6agR5DpOdPAD6gzya2ULpmA8X/Zi+Fwz8OwSAK60RpbZt56iF4Bnkf57ojFhAkTDkU1BJ5xvQ+AagsIyTeZ9xAKVY=
X-Received: by 2002:a6b:5f08:0:b0:688:9846:2f61 with SMTP id
 t8-20020a6b5f08000000b0068898462f61mr290298iob.65.1661373417623; Wed, 24 Aug
 2022 13:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220824130702.10912-1-khalid.masum.92@gmail.com>
 <YwY4cVdB3tVVMIqJ@rowland.harvard.edu> <CAABMjtFEfgQtcGKLkd=whFN=WHUywTg=fDAxRQ+zKLiqOFhvQg@mail.gmail.com>
 <YwZ6/qkEAk8867qh@rowland.harvard.edu>
In-Reply-To: <YwZ6/qkEAk8867qh@rowland.harvard.edu>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Thu, 25 Aug 2022 02:36:46 +0600
Message-ID: <CAABMjtH8WqoraFLQ=-TTwah=A+PRjRjJ2hS-ySK_5h9qYyy8Sg@mail.gmail.com>
Subject: Re: [PATCH] usb: host: Use helper function to get endpoint
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 1:24 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> udev is not a usb_device structure; it is a _pointer_ to a usb_device
> structure.  The pointer is created when ehset_single_step_set_feature()
> calls usb_hub_find_child(), but the structure itself gets created long
> before that, when the USB device is first detected and initialized.
>
> You can see this happening where hub_port_connect() calls
> usb_alloc_dev().  The ep0 field is filled in by hub_port_init() and the
> routines it calls.
>
Thanks for clarifying this. That helps a lot.

-- Khalid Masum
