Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0D4F1907
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355175AbiDDP7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiDDP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:59:38 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C33EF34;
        Mon,  4 Apr 2022 08:57:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 09EA9419BC;
        Mon,  4 Apr 2022 15:57:35 +0000 (UTC)
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To:     Christoph Hellwig <hch@lst.de>, Sven Peter <sven@svenpeter.dev>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
Date:   Tue, 5 Apr 2022 00:57:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220324061620.GA12330@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 15.16, Christoph Hellwig wrote:
>> +
>> +//#define DEBUG
> 
> This should not leak into the driverṡ
> 
>> +#include <linux/blk-integrity.h>
> 
> As far as I can tell this driver does not support metadata or PI,
> so why is this include needed?
> 
>> +/* NVM Express NVM Command Set Specification, Revision 1.0a, Figure 18 */
>> +#define NVME_OPCODE_DATA_XFER_HOST_TO_CTRL BIT(0)
>> +#define NVME_OPCODE_DATA_XFER_CTRL_TO_HOST BIT(1)
> 
> Please just use the nvme_is_write helper where you are using these.
> 
>> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
> 
> Please avoid > 80 character lines.

The kernel hard limit is 100-character lines, not 80-character lines.
Maintainers for existing drivers are certainly free to stick to 80 chars
if they like it that way, but I don't see why we should still be
enforcing that for new code. See bdc48fa11e46.

And also:
https://lkml.iu.edu/hypermail/linux/kernel/2005.3/08168.html

Quoth Torvalds, addressing you personally:

"If you or Christoph have 80 character lines, you'll get possibly ugly
wrapped output. Tough. That's _your_ choice. Your hardware limitations
shouldn't be a pain for the rest of us."

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
