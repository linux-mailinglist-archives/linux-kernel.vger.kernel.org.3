Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76E5875E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiHBDUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiHBDUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:20:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA105266D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:20:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y127so21835582yby.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 20:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0RRsjoUyem/Uu6X8omWbmsj/Rtm7+eGWCw7Bg5wOuk=;
        b=fJfp67jot0JG7C9ufb0tEJZH2wfzDUaQhd+8KHwzRqYFr3b+slwkXVhS7A5677iBte
         yoyvZ7FNGiJJS1hHre8mX7otvQ8fhp7BOv7LoBNMve+fbsDvPeTPtJnCJc+rSF3kQnyV
         94Gmr5ANWthxdPgsvStd5CIg0UZegP8tQqfIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0RRsjoUyem/Uu6X8omWbmsj/Rtm7+eGWCw7Bg5wOuk=;
        b=SSj9dSAFg4iRLvTFl8IkPmgB3zCg93YV+rLpzQFsZ/+JT+LXar8M2RhE9FRnwGuair
         B0BnsyibPSYYpy5tcITAUC8KV++wXvFV7qbb1oodT2kLhTT7ZqdPHc4VAeehJntLdNxf
         BiAkdlHebySmni74/nsmjc+uqPzUHtLzh7JQKUay91YPDyFawb5R/azID2JiEoH412dS
         7LYX1h9VFsG+FnW0uH5Ul/vbtPgukfhLrHq037UYZQMq5YZVOdfsavE+OJ7hcuggm8Tl
         FPrELiFXs43+RR+E8RFhAekUgYVA30iP+v/efiiqltWHHZN3nPaFAUv6m2tKxwR6RVTn
         0PYQ==
X-Gm-Message-State: ACgBeo1Lxtnc9aswVpvI7xomg3gTtElKmFPhVtKw5tZafGlhBXI5TysU
        Haq9pLTz2gQpf/omdnBt5/v+s3uakpqEvcrqhqLIaw==
X-Google-Smtp-Source: AA6agR45GVkAIWzB395IwGRNxzpFkXaVilMwK8OytxnFjfxML6ca852d/ZTtoG6iW2/mTgBoX1AwOX+HoHm4VVBsVuM=
X-Received: by 2002:a25:7cc2:0:b0:677:5a84:9f79 with SMTP id
 x185-20020a257cc2000000b006775a849f79mr4142817ybc.518.1659410415884; Mon, 01
 Aug 2022 20:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220802103643.v5.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <c4acb34f-7bba-336f-ddfc-a9c098f2c95f@acm.org>
In-Reply-To: <c4acb34f-7bba-336f-ddfc-a9c098f2c95f@acm.org>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Tue, 2 Aug 2022 13:20:04 +1000
Message-ID: <CAONX=-cAW5UX__xu5y7NdtHkZq-YWmh_k=iFa5witdxw3xXkYA@mail.gmail.com>
Subject: Re: [PATCH v5] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the "capabilities" directory a directory with capabilities of the
> host, with capabilities of the UFS device or perhaps with capabilities
> of both?
I would say effective capabilities of the controller-device pair, from the
semantic that hba->caps field presents. Do you want me to mention it
anywhere?
Thanks,
Daniil
