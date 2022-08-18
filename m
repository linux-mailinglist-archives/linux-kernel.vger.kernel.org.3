Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF10598A85
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbiHRR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344870AbiHRR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:28:39 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F705C941;
        Thu, 18 Aug 2022 10:28:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 532394E5;
        Thu, 18 Aug 2022 17:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 532394E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660843715; bh=Ls9/prGid4V6GXxs+WbDuCXxIerbPP3MEZHZAl8XqAM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CMLL1Z9172wh6gaeuanPp7QBqkF8SNaTDZfaPOhdy0zdER13Uw6qNjlErJg0x9zo6
         nT+iExgs3kXOmKooq2O8jWxh9IWmUV8JX4iZpvKfB/0FaqWlIeDC2JUOxMXlEbS+om
         U5fG97qF1PaMU30qawWNDconYVbWbBzyzd3p8WN+8fxf2ftHglqqwxQ1WFCncBMYTc
         IKC3kFeQI5Z+sjba//e5Pa/qUIpOWe8bgcvirkqoE0gUYClSQv27SoDEHX6RYFC07b
         axjDsesdHYQho/dFleHn9Am6oTFD38acgBJrpPZzgKXTWc4Xh/DrQjyNobngdVrTuk
         DAdDEoMEBxipw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 3/3] docs: kerneldoc-preamble: Test xeCJK.sty before
 loading
In-Reply-To: <278e0041-a2df-d067-59eb-87b8ac178567@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
 <c24c2a87-70b2-5342-bcc9-de467940466e@gmail.com>
 <278e0041-a2df-d067-59eb-87b8ac178567@gmail.com>
Date:   Thu, 18 Aug 2022 11:28:34 -0600
Message-ID: <87o7whbgvx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi Jon,
>
> On Mon, 8 Aug 2022 17:53:57 +0900, Akira Yokosawa wrote:
>> On distros whose texlive packaging is fine-grained, texlive-xecjk
>> can be installed/removed independently of other texlive packages.
>> Conditionally loading xeCJK depending only on the existence of the
>> "Noto Sans CJK SC" font might end up in xelatex error of
>> "xeCJK.sty not found!".
>> 
>> Improve the situation by testing existence of xeCJK.sty before
>> loading it.
>> 
>> This is useful on RHEL 9 and its clone distros where texlive-xecjk
>> doesn't work at the moment due to a missing dependency [1].
>> "make pdfdocs" for non-CJK contents should work after removing
>> texlive-xecjk.
> In hindsight, I think this qualifies as a stable material.
> Let me append a couple of tags.
>
>> 
>> Link: [1] https://bugzilla.redhat.com/show_bug.cgi?id=2086254
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Fixes: 398f7abdcb7e ("docs: pdfdocs: Pull LaTeX preamble part out of conf.py")
> Cc: stable@vger.kernel.org # v5.18+
>
> Jon, it's up to you whether this one is destined for v6.0-rcX or
> for the next merge window.  It has no dependency on patches 1/3
> and 2/3.

OK, I've gone ahead and applied it with those tags.

Thanks,

jon
