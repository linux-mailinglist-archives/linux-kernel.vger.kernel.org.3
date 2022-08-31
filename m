Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D575A753D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiHaEn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:43:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E19C2F1;
        Tue, 30 Aug 2022 21:43:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHWfm3w8fzYcwt;
        Wed, 31 Aug 2022 12:39:28 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 12:43:51 +0800
Subject: Re: [PATCH -next 2/4] spi: mockup: Add writeable tracepoint for spi
 transfer
To:     Mark Brown <broonie@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-3-weiyongjun1@huawei.com>
 <Yw5Ta8sO3fMsPLDY@sirena.org.uk>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <bc4dd16b-e2f8-9734-8db8-78500f361f5a@huawei.com>
Date:   Wed, 31 Aug 2022 12:43:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yw5Ta8sO3fMsPLDY@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/31 2:14, Mark Brown wrote:
> On Fri, Aug 26, 2022 at 02:43:39PM +0000, Wei Yongjun wrote:
> 
>> +#define SPI_BUFSIZ_MAX		0x1000
>> +
>> +struct spi_msg_ctx {
>> +	int ret;
>> +	__u8 data[SPI_BUFSIZ_MAX];
>> +};
> 
> This has a hard limit on the size of messages of only 4k on the
> size of messages, that seems a bit on the low side especially
> considering that the example is for a flash device.  There's also
> things like firmware downloads which can easily exceed 4k.  The
> driver should at the very least report this limit via the SPI
> API, and probably also complain loudly if the limit is exceeded
> since it's unlikely that most drivers will actually be checking
> for such a low limit given how rare they are.
> 

We need a limit because of BPF writeble tracepoint only support const
size buffer write now. This limit can be fixed after make BPF support
dynptr write.


Regards,
Wei Yongjun
