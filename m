Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0A52CA71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiESDju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiESDjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:39:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465AB692AF;
        Wed, 18 May 2022 20:39:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v11so3983738pff.6;
        Wed, 18 May 2022 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=yN69T3VlLbhWzqaJ04/Cruu+aC3pD4q/ss9q7X7d+FE=;
        b=O8SV9hdkE/2vj4RLhxwpWjcWg2MmD/u6TYK5SqYSCu5WCmhJAYJ+RUHEsv3o/P2ysQ
         bRQKp4ojl1sa53WL3E9LzfFg27FlqAdedOb7PSo004MffWmLAPSUznXHoPxnt8TcTzDd
         uXY/1HfmkKSt+YqRtwtKxOELNNfyrtSjAVgNI3z+xHzNXOYc9hs3k90qznkA7yyx6fOY
         m02VrVUWbUPYkt6DrMkhT8SQjGjtR/U1EZF+jlbibSj/QitF9dyFKT9jvQ/VkvYcaRL8
         cC/2SZqK5ir6P4q41NhWjX1LaVkFjqGAw4Y0evqleL8x+DoBbeZpIbnq1/Og+H8+YYDg
         zsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=yN69T3VlLbhWzqaJ04/Cruu+aC3pD4q/ss9q7X7d+FE=;
        b=o4nJW667z2cb/rgwP431cXCqxfAUiN2XUDF1kIECL3hW/O5tJIh8mtbHUTpQc5bRgZ
         Ln3cTNcFh6CsZpHeV9W134sGFs1KR0x7X658/7cUDDFXjNxBobqsUpaKb7yuUVF5lmak
         SbzfP16HHJXkEA+wq/bSamaASPwra12itzRpvVpAqKPUGoQqcm5pMjTWybLkGSqh01E0
         FYw2hx1Q2kXAz50W/r/RjME+KhMI3CgIwfMRGqhrtxthFTMeyLOAZv+C00cdM9aa5LWj
         HOIwpaWU3bsG1Zp5/52Ls6zQbgcNTyPI1H2ddPHqWMCG0WJ+IVk6WpTZ35ghvYMwtvgv
         DEiA==
X-Gm-Message-State: AOAM531d9ueCouCVvz7rqhMTLfSBzmdC7LQmvaZJo+YwqA7OMqZdNwvG
        cYnf2J7vuqxGJaKHjnxWaIQ=
X-Google-Smtp-Source: ABdhPJx30F806uRbpCNtRmzK2AGNOrstjwNN4/n2kuy2Me5b9xpDht5tUrZRNMmwBhAwfAj+zwzxYg==
X-Received: by 2002:a63:1b49:0:b0:3f2:cf90:5ad4 with SMTP id b9-20020a631b49000000b003f2cf905ad4mr2275090pgm.450.1652931585799;
        Wed, 18 May 2022 20:39:45 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b0015e8d4eb21dsm2542589plf.103.2022.05.18.20.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 20:39:45 -0700 (PDT)
Message-ID: <6285bc01.1c69fb81.c4048.6665@mx.google.com>
X-Google-Original-Message-ID: <20220519033943.GA1735704@cgel.zte@gmail.com>
Date:   Thu, 19 May 2022 03:39:43 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:31:26PM +0200, Jann Horn wrote:
> On Tue, May 17, 2022 at 11:27 AM <cgel.zte@gmail.com> wrote:
> > For now, if we want to use KSM to merge pages of some apps, we have to
> > explicitly call madvise() in application code, which means installed
> > apps on OS needs to be uninstall and source code needs to be modified.
> > It is very inconvenient because sometimes users or app developers are not
> > willing to modify their app source codes for any reasons.
> 
> As a sidenote: If you're going to enable KSM on your devices, I hope
> you're aware that KSM significantly reduces security -
> when cloud providers were using KSM, there were a bunch of papers that
> abused it for attacks. In particular, KSM inherently creates
> significant information leaks, because an attacker can determine
> whether a memory page with specific content exists in other apps
> through timing side channels. In the worst case, this could lead to an
> attacker being able to steal things like authentication tokens out of
> other apps.
> 
> If you see significant memory savings from enabling KSM, it might be a
> good idea to look into where exactly those savings are coming from,
> and look into whether there is a better way to reduce memory
> utilization that doesn't rely on comparing entire pages against each
> other.
> 
> See https://arxiv.org/pdf/2111.08553.pdf for a recent research paper
> that shows that memory deduplication can even make it possible to
> remotely (!) leak memory contents out of a machine, over the internet.
> 
> (On top of that, KSM can also make it easier to pull off Rowhammer
> attacks in some contexts -
> see https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_paper_razavi.pdf
> .)

Thank you for your reply. The information you provided is very
meaningful. However, the administrator should have the right to decide
whether to use KSM. The kernel should provide a flexible mechanism to
use KSM. How to use KSM safely should be decided by the user's security
policy.
