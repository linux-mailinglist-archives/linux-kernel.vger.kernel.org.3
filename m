Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A852E3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiETEkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245673AbiETEkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:40:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589B66694;
        Thu, 19 May 2022 21:40:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k8so6009415qvm.9;
        Thu, 19 May 2022 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tDtdlYQr3ZnICqxhHWue/7/HUL0RgbmyKzlToAt3/hw=;
        b=eYqh5iki0Y+XAiUKad9/LCZa3AO0Q+boa46Tt2CS1A/+3hejAHxR0O2X7k+JgYomIO
         ZBAOo0vZmg2ohgimVDLDcEu7rArMQwmmnCShl3Xpb5xnT8xD5SYsAMCwEMRqCN4e1BOq
         q1nijOf/fKsRdLhYfIybiSSB0RKbua4OOgwNd/NCRhFa79N8F/+RUJUb9NMBK0dv83Qr
         aEFYfYNW4srNPVolN/vBOcXRZaRv7Q7MW/lGNhOCoUE86+sRFjbS4aiHSgycvQV+Kwjd
         x1LTOh05/vEAk9IB29SjK4nxi3w0lSW7Zwir8Q2HCOFW8Z4Ah/epmra8G+TYozp/tSzx
         9LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDtdlYQr3ZnICqxhHWue/7/HUL0RgbmyKzlToAt3/hw=;
        b=lLL5omLj3FAk89njykZ86Ty+ktwHlv3t4LF16sy+9YJRlX6B+G2Z1pfhgVujuMcxF9
         V060QD1whjE8N0tSk360ePmNQGvb498bkm4aDrqMWILcFnjRL0NMeqE2YnPIr1SXNr4C
         jdlzzkppjaUi24jT8nGbMBOBvLQAQ/fPI0nycWMCMDGahwiE9FqAeVzAuzKsHRLNbXGl
         82qla9Khzyt0x+7RP+Wy+rbGOaZTROanqXsOfqoqSyIcE+mDc1cf9Ll/sU7PD1wl+1f4
         3Vx3iWw3p144RFSufBBsZwPnzvmBexEMEveilsWrDiaIKe9WUF3d6r4QYpptbftkN+ak
         v83w==
X-Gm-Message-State: AOAM530ZrSYdv6Z9dGK/U8muceeUPsGsCO+w4590ehIjH+bUdyNihbDA
        2bY9J4h19b4tSRTd4zEpcQ==
X-Google-Smtp-Source: ABdhPJyWiOJK5X1ND4tndwrymgtrKLFoppnwqkPLL/oP+y2dH9U5ntuVB8eV6GsU4SUSjc8Yvtr+/g==
X-Received: by 2002:a05:6214:20ae:b0:45a:ecd3:f582 with SMTP id 14-20020a05621420ae00b0045aecd3f582mr6645163qvd.46.1653021637263;
        Thu, 19 May 2022 21:40:37 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x139-20020a376391000000b006a0ff3ec18bsm2328107qkb.122.2022.05.19.21.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:40:36 -0700 (PDT)
Date:   Fri, 20 May 2022 00:40:34 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <20220520044034.gdmip5whu5cdv6ir@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
 <Yoam1bW/vni3srLc@smile.fi.intel.com>
 <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
 <YoayjKMjhRVCiKKl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoayjKMjhRVCiKKl@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:11:40PM +0100, Matthew Wilcox wrote:
> How about:
> 
> 	if (v < 0) {
> 		pr_char(buf, '-');
> 		v = -v;
> 	}
> 	pr_human_readable_u64(buf, v);
> 
> (some pedantic compilers might warn about the behaviour of S64_MIN, but
> I think we're OK)

Yes, since S64_MAX == -S64_MIN and S64_MIN == S64_MAX + 1, the code is correct
for v == S64_MIN.

But I still prefer my way :)
