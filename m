Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6D4E4827
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiCVVOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiCVVOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:14:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F1F11A2D;
        Tue, 22 Mar 2022 14:13:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l8so19280269pfu.1;
        Tue, 22 Mar 2022 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03tYtiA5KKmFTpDLZLnqLpWtIG1hK5GKwEWKVkVUCGM=;
        b=AymEJ3DLGTRyadwp2af38C6hVt6EF5qW0et5KZg3nCgeQNz5X4yY2EGTqECzqlvkhX
         VKpCXWGL9an+EFgF1DcbyC/4zZa5JFRser4DLlEt938uP3Zj1owzzE4Z8bqrEnkhp1yk
         Ev7E/diLUu+ITuMxWWbPG53krPRQbuURR98qGKMxulWz9CGw/qpFOv4wfGde8ORnIxcS
         Bl8Q8p0pVoJWXTW/ZuEutbTzPplBZ+C0+EOR6XdLQmYtALY+SlNKJ2IxLGy5QAQPdwNa
         Sahxs2DsIyOK239Cuc87dCJquzxveRbcO00pPP3WqYfE5w9es4c+BibGbzb9GzYA0Gj8
         GOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=03tYtiA5KKmFTpDLZLnqLpWtIG1hK5GKwEWKVkVUCGM=;
        b=umm8+yNfGXAanocBPP7r/Yf2eaIfQ4RyFbteBaPm7toZOQyUgDpeCSqowWZ3fg3vnW
         vPNCUkU+bKQqV8SX529XMXBrKXoZNTiwvYweY1DCrRJzTImOkRciMiqta8ISpS/KL8d8
         s57lgaJ+XrZoaSFW6D/083kMxGL5GRUS4M0yiGTrMB5aHZivOE8dumz+5zLAbnzSi0B/
         yi0o3S40kOGNxcHI1WK4uiYZIhE8Dk3AeVIECTtIPMv3dSIK5NMcfSEbEwE9ARyVSeI7
         GyFu2g+MbKFSYJxiNVREaOxLJ0yNP+iqCuinvEepfliOMaMtQpxV2GjjWUU8E+9ExHeC
         EQUg==
X-Gm-Message-State: AOAM533rcUgsNxlHWvJH8IRioLvn3fS8Zr5cK512CaTQ/LSxPMFSDWqM
        hDpv4tYtznjymK3trRAWtEk=
X-Google-Smtp-Source: ABdhPJwDqReX6cCd1yPNLAr6G/6vxoxQ+ACIXmA+YyRvFv8WA+XFEnDNCwAOpDMr0gNEp5BJzHkr7g==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr19416543pfh.14.1647983591745;
        Tue, 22 Mar 2022 14:13:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f2c8:5487:5fb6:3ab8])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm24208931pfx.34.2022.03.22.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:13:11 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 22 Mar 2022 14:13:09 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
Message-ID: <Yjo75atYTpXqCM4g@google.com>
References: <20220315172221.9522-1-bgeffon@google.com>
 <20220321145037.1024083-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321145037.1024083-1-bgeffon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:50:37AM -0700, Brian Geffon wrote:
> Today it's only possible to write back as a page, idle, or huge.
> A user might want to writeback pages which are huge and idle first
> as these idle pages do not require decompression and make a good
> first pass for writeback.
> 
> Idle writeback specifically has the advantage that a refault is
> unlikely given that the page has been swapped for some amount of
> time without being refaulted.
> 
> Huge writeback has the advantage that you're guaranteed to get
> the maximum benefit from a single page writeback, that is, you're
> reclaiming one full page of memory. Pages which are compressed in
> zram being written back result in some benefit which is always
> less than a page size because of the fact that it was compressed.
> 
> This change allows for users to write back huge pages which are
> also idle.

Hey Brian,

I really want to add your explanation about the storage endurance
because it's real issue.

So, could't you add up below in the description?

From your previous reply
"
we're trying to be very sensitive to our devices storage endurance,
for this reason we will have a fairly conservative writeback limit.
Given that, we want to make sure we're maximizing what lands on disk
while still minimizing the refault time. We could take the approach
where we always writeback huge pages but then we may result in very
quick refaults which would be a huge waste of time. So idle writeback
is a must for us and being able to writeback the pages which have
maximum value (huge) would be very useful
"

> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>

Other than that, feel free to add my
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
