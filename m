Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2235F569D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiGGI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiGGI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:27:23 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F414D21;
        Thu,  7 Jul 2022 01:27:20 -0700 (PDT)
Received: from usmail.veeam.com (colmbx01.amust.local [172.18.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 410621BED3;
        Thu,  7 Jul 2022 11:27:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1657182438;
        bh=9JTT03ywMrfFf8Wc1PmkKBuL5TV4H/+eK+u9HUsy8r8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=FWo545DE5ALoyzMmYKIG4JrOpsupyPySRmzVtTD+ZHL/Eqqur+HEZoVW5js8jjfQa
         QcBfkDawEv48Y3RrDaynRVzEjyygp807vwzp1YhVTq1JVlTb4COUgUGDu8XSi5wwAR
         dNF15T3fhtuxSqS/66FTUgki5h+CdJdywgMTo8M5X3rsMSq7HtiVauVa/I40w++dZt
         ZVMlnTLnUfHtgERxoXpkjaRlXTC2go3Qxlt+bA+8HRHvoe28lc6uOhXxEWMIIrdnUF
         R5xKVpCnzsUcSMcxA5pJ5rTxfnV0sXk9ejtPuHd7nNCXVRSOP3fJIgJG9jcQVYQ0C8
         /XwZJ3y0eIfNA==
Received: from [172.24.11.83] (172.24.11.83) by colmbx01.amust.local
 (172.18.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 7 Jul 2022
 04:26:56 -0400
Message-ID: <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
Date:   Thu, 7 Jul 2022 10:26:55 +0200
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
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <YsWHHcCfSVFklh4M@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.11.83]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 colmbx01.amust.local (172.18.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29078F7554657267
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Christoph, for your attention to the patch.

I am preparing the next version of the patch. In it, I planned to
simplify the bdev_filer code.
I will make changes in it, in accordance with your comments, and
will add your code and check it on my test labs.

But I'm not sure if using the blk_mq_freeze_queue() is appropriate.
If I understood the code correctly, it is based on the expectation
that the counter q->q_usage_counter will decrease to zero.
To increase it, a blk_queue_enter() is used. And at the time of
calling the filter_bio() in the submit_bio_noacct(), this counter
has not yet been increased. I will double check this and try to
get rid of the bdev->bd_filter_lock.
