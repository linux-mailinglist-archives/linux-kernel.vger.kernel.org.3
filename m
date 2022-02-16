Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D04B7C88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiBPBYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:24:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiBPBYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:24:13 -0500
Received: from mail-m17640.qiye.163.com (mail-m17640.qiye.163.com [59.111.176.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257013CDD;
        Tue, 15 Feb 2022 17:24:01 -0800 (PST)
Received: from [172.16.12.40] (unknown [58.22.7.114])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id D921E540269;
        Wed, 16 Feb 2022 09:23:58 +0800 (CST)
Message-ID: <0ee7ab71-5d01-58e2-baf7-4dd41455b377@rock-chips.com>
Date:   Wed, 16 Feb 2022 09:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/6] spi: rockchip: Preset cs-high and clk polarity in
 setup progress
To:     Mark Brown <broonie@kernel.org>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-2-jon.lin@rock-chips.com>
 <YgZHalrdhhilxROt@sirena.org.uk>
 <4222ce7d-a1e3-1728-fec2-976946b06ba9@rock-chips.com>
 <YgpP9j80OuhkCN8p@sirena.org.uk>
 <e0f0ca0d-40df-cf86-9471-9272bcc171f9@rock-chips.com>
 <YgueWHKur2w55s+0@sirena.org.uk>
From:   Jon Lin <jon.lin@rock-chips.com>
In-Reply-To: <YgueWHKur2w55s+0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIaGUJWSR9NTkgdShgfHU
        geVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Eyo4ST5IOBZLAUMVCC9N
        MjowCS1VSlVKTU9PQkxPTUhCSEtDVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ05MNwY+
X-HM-Tid: 0a7f002107c5d995kuwsd921e540269
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/15 20:36, Mark Brown 写道:
> On Tue, Feb 15, 2022 at 11:00:54AM +0800, Jon Lin wrote:
>> 在 2022/2/14 20:49, Mark Brown 写道:
> 
>>> As covered in the documentation setup() for one device may run while
>>> another is active, therefore if multiple devices are configured in the
>>> same register you should use a lock to ensure there can't be multiple
>>> writes.  Note that the above appears to not just be setting the mode but
>>> also the chip select so if you've got two SPI_CS_HIGH devices then
>>> they'll both be going in and separately setting cr0.
> 
>> Is the io_mutex in function spi_setup is good enough?
> 
> It's not supposed to be for that but looking at the code quickly I
> *think* setup() is never called with io_mutex held so it might well be
> fine - you should double check though.  If not you'd need to add another
> lock in your driver data.

》setup() is never called with io_mutex held
I think so. and I think the io_mutex is enough for me.
