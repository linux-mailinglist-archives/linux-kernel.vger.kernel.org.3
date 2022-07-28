Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1954583784
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiG1D2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiG1D2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:28:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915E550AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978898; x=1690514898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=02fS6kchwHqmWpcjqgwh7Tp2AzoaPQbPCdZwujO0Kqg=;
  b=ebNSs7pufZdB2jxBPBzd7dgCHxscneSGI6IIV0RNynq/W0OsnyhlvfPQ
   oMe3hit+XUWvEebCtgw3ipF2j99YsvbJOhVfchOhne3QPYp7uvz6HI71U
   NwT9ByTfrpPmANI5Z2h1sK3NXbcy95UhV8gBHMpzvU6qdqpjbRdmH2Ojk
   rBjI9757XvLz+rcNnAZ6DmOXImNGQwlgCc1X0S8FUEhJMkB8PBySZ89dD
   YedR6uDQX09GJnAnGvezTia3+qrcQSOe29EiemsjQev2SSzo/FBknDwmc
   CwobEKDliWRbCi657Qqn2r+1I1fNblsVKj31pFa6KgY6JSHcfgGE3MOdk
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212068006"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:28:16 +0800
IronPort-SDR: yBEMvH1vGZkl8cDyLmFJqkIyvPmUGaexI+m0eZO4N9i0Am2wVP1ZSwxKSGsbFNDmVhMM7/Bs/M
 qq49k9Djgs9bp4rONj82EkefLwk1/I9IKThtKXwghYQbm5G9X+t2bcPyx1lDeUslIRR8jpm7DR
 m9e4rphvKiSjLgLXaswzPCnB1GlNV2BWtQMjF60IvBiyoqV7nA15zGL2vnK+6YvtbfjIim61Af
 Zq99GLfjtcCWGKzqW26v1TDp9P6lCcRpaIhppmppolqjuxzYEXH3oh5LJT3T9Xv4nT9td59ncZ
 ogfGLTjzVOGJbYi8+4A8mhKc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:49:28 -0700
IronPort-SDR: HlkXfcOKbxHnQwnH85Da5RkeEJmDGtLlEiJDquDEHKYe9X4ZGwc3dxk4Em0c50NUGx97D2sHdl
 ytCjK9+QafHfr9rUJ3Y3o1sml0QTLBTU511eTcxdxcILC94O+Z94348lB4vtqjV21hpXtjvCa7
 u0DR6TnkcNpQWa2Dt/7BisvHQopHFDE00oCNwo8Id2p7CPOqIKKSYHcpstADHvj0pbTUeJ4u5S
 MAcBqpAG5xe+IErYPqzEaksC4y+0+e8i2Y/QEGj8uNFtu5idZ2PqJf+lX/SY7CK8nCr2nW/pZG
 6Ho=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:28:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbhK0jnnz1Rw4L
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:28:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978896; x=1661570897; bh=02fS6kchwHqmWpcjqgwh7Tp2AzoaPQbPCdZ
        wujO0Kqg=; b=XFj0iZ2qucRNXLvFvXz5w1dYpBhlsBsRLOWUCDbt4fCiLXdAV6Y
        EQ5yZt4COhh4esfTwI+5n8phzk0DKhRlSBMuEgz/TSdi3vkF9IawGK6oLlSQ6ynw
        pRe1E2/Ri7WHz75PPOX8xR0XrGnfs9inuaZwmtBMKUBkRtl9zoeD9iQLQhlj+Q4F
        qe7dgyUliqOVxwY0+i+h637LU+UfWy3vzjZcOteVlJEsbp6dRJ/oxNdGPGz7CHBJ
        v6j+Jx4i6/gyJ6F0gmni39waRSmg6HG4ocQI+vUURpMBU0U/SlmvVpGwv+Eqpvxg
        vCMwy8P+v5ZWPx1otBPBM2IdIE8W6cFWpEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IiookUF0rTFz for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 20:28:16 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbhF2DLPz1RtVk;
        Wed, 27 Jul 2022 20:28:13 -0700 (PDT)
Message-ID: <14108b56-10c9-8760-39b1-ffa56220e5a3@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:28:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
 <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
 <024d16ac-d685-0fcf-1ad3-e99946852b03@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <024d16ac-d685-0fcf-1ad3-e99946852b03@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 11:58, Bart Van Assche wrote:
> On 7/27/22 18:52, Damien Le Moal wrote:
>> On 7/28/22 08:19, Bart Van Assche wrote:
>>> On 7/27/22 09:22, Pankaj Raghav wrote:
>>>> This series adds support to npo2 zoned devices in the block and nvme
>>>> layer and a new **dm target** is added: dm-po2z-target. This new
>>>> target will be initially used for filesystems such as btrfs and
>>>> f2fs that does not have native npo2 zone support.
>>>
>>> Should any SCSI changes be included in this patch series? From sd_zbc.c:
>>>
>>> 	if (!is_power_of_2(zone_blocks)) {
>>> 		sd_printk(KERN_ERR, sdkp,
>>> 			  "Zone size %llu is not a power of two.\n",
>>> 			  zone_blocks);
>>> 		return -EINVAL;
>>> 	}
>>
>> There are no non-power of 2 SMR drives on the market and no plans to have
>> any as far as I know. Users want power of 2 zone size. So I think it is
>> better to leave sd_zbc & scsi_debug as is for now.
> 
> Zoned UFS devices will support ZBC and may have a zone size that is not 
> a power of two.

OK. So the check needs to be removed then and the entire zone append
emulation checked carefully. The divisions for zone no etc on non power of
2 zone size devices in zone append emulation hot path are really not
welcome though.


> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
