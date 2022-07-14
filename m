Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D95748AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiGNJX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiGNJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:23:18 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E148CA2;
        Thu, 14 Jul 2022 02:22:09 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 9DA1FCFD7E;
        Thu, 14 Jul 2022 12:22:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1657790527;
        bh=jgDNoCLPmRwx1oECIx6iYAVPPHpCU00AiNgR1aHWDXk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=na4sGOigYK9z63vlo4ATlsIOkDmM+vH83TDFMAQSa0jOAlUiPF1vWsIOOfJrbrA6b
         0FyL7foFEvY+j1eYdt0Wb3Gv9/FqsHCcRdY7vRkThVSKzOL0p1ows3Bw/KTmHgAKb+
         PhVTDdum5WKdgNeZnSOdc1Vjp/5Knr0pI3rAiI6ylj33pgBuZ1kGVOR4UFEBricR0B
         xEpV5CSzz+jMO4fPr33VdsDTs89UkJs3YhLArNj4ZblH2+4DCQqBGmRKDfqma1GZXQ
         wELjjgn82CWs1SRaN1QHzZmUvdMGCpgWY9QIEjyxymmskr3hB+JiSQJSUldlqlvNOY
         E9ByaIHy3RsnQ==
Received: from [172.24.11.83] (172.24.11.83) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 14 Jul
 2022 11:22:05 +0200
Message-ID: <eac05a59-6010-460f-3a8e-0c7887e4ec63@veeam.com>
Date:   Thu, 14 Jul 2022 11:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
 <YsWHHcCfSVFklh4M@infradead.org>
 <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
 <YscXTGXumE5Ust15@infradead.org>
 <aec88137-070e-7c1d-215f-86a1e6d4b10a@veeam.com>
 <Ys6y1AYTl8r/i3UX@infradead.org>
 <51e3fc9e-5b46-ab23-bbf8-5d0ad9dada29@veeam.com>
 <Ys+louzW6t13oUpD@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <Ys+louzW6t13oUpD@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.11.83]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A54647060
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/22 07:12, Christoph Hellwig wrote:
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>
> CC:
> Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> 
> 
> On Wed, Jul 13, 2022 at 03:47:23PM +0200, Sergei Shtepa wrote:
>>>> 2. Can the filter sleep or postpone bio processing to the worker thread?
>>> I think all of te above is fine, just for normal submit_bio based
>>> drivers.
>>  
>> Good. But I'm starting to think that for request-based block devices,
>> filtering should be different. I need to check it out.
> As long as you filter in the submit_bio stack you handle both submit_bio
> and request based (blk-mq) drivers.  So I don't think we hould need
> to handle them any differently.
> 
>> I have a lot of work to do to improve the patch.
> If you have any questions or want to get feedback on iterations not
> ready to post feel free to ask me offlist.
> 
Thank you very much.
When a worthy question matures in me, I will take advantage of your offer.
