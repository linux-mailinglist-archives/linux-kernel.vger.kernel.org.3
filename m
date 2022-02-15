Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E714B7A40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiBOWMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:12:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiBOWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:11:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259C26579
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:11:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4so539657pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dg8Bbqo8xrTURRSZr1gbJA1kXH+dR6Cfw/CPc1vh5OA=;
        b=JWDZBiIvBXJ+xyw/ssMlbLaY+HL0dGj6fRKKopQM/zAdOrPiEpBBbN0hIHBWPjTwv7
         phWt006J1z/OGnlE0pZ1IAr4MBG61MAESVtMLCJJLdN03Qgw5ph3ybjNDcm5KLD4H/Bn
         dWXl2k4tg6j6b6r3iLke/JjQOqtAWGhWjmz+5X/AmIsbrRbdPwocCDW6gnbjWLV+8CGP
         6XBgMZj2Vbtv7WovHLG8U9O+XTiFW1Esdpsq5PDNf7YwiqhlubKB9tjZcJrQw+cD3SxG
         3OYRHWmQVG+2jcAaW9y66JUIwQHgJwy+IQgpES3zBB50Hn7Ps4/BtqJ1QikahSxmXMbV
         ZLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dg8Bbqo8xrTURRSZr1gbJA1kXH+dR6Cfw/CPc1vh5OA=;
        b=SfDRmASEJXSCbwzGcWooxdtRuqEX0iu9lpZ9md94NtKADo5ESFtApw774ti4/35ICj
         7GAnTusVNE4RqqFmC8nRKe/kWSEOEsRtHwNXIA7lGqQH3kUy5Fs0Yqrq8bf0mp0PRSy6
         nFNZUTsP3ZxbTI1wyAUWoRPqk1TyGlM/uDKqjpSiOitptQq4z46SiDJxOTqfaU5KHV6S
         8tcG8mSZtdkv41KjvEKf0boy8+62ZpJhRXudL6v4PesbOi/w4EcOplKiuYfal3euhjI9
         5JAgZcQ6gz6W5TmziXVDWsN1lZB+0YG7KtBrDTJ0PX9tJzmdMDNTi+3XnYYh1I/RerDo
         O3iw==
X-Gm-Message-State: AOAM5319cn7nxaquiOFEv6cGQERw6zXFGTkqBl09oU83gsG9YNj5xZJb
        D0bI4OeZCtlNDOVT64QvZ7rrq/arUOX2itIV5boyzw==
X-Google-Smtp-Source: ABdhPJyiswDhX6qkwwQts1SFepTHj/P5w6WGlYQlgTjrpG3xns33VOfe9EvdjD9DCBoIscPBLRLRybo05bZTeUzOoys=
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr1046139pjb.220.1644963108677;
 Tue, 15 Feb 2022 14:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com> <20220127124058.1172422-3-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220127124058.1172422-3-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 14:11:42 -0800
Message-ID: <CAPcyv4jMBm3ewWeQX7eZDaHT4aD8eOPcxYBiiZT1ZmaV9z-A2g@mail.gmail.com>
Subject: Re: [PATCH v10 2/9] mm: factor helpers for memory_failure_dev_pagemap
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> memory_failure_dev_pagemap code is a bit complex before introduce RMAP
> feature for fsdax.  So it is needed to factor some helper functions to
> simplify these code.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
