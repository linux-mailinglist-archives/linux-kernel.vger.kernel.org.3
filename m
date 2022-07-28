Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D196D583688
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiG1Bwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiG1Bwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:52:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4C52E74
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658973149; x=1690509149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QVVBWQ6JmTLGyCI9T6RhLFvgwT91qI0IoKUt3pFI0/Q=;
  b=DLLrEgG0gxpDW78e8dy1cun5JMHthI+Z14UNU16myT3qWiyMZaJvfdjm
   rjKpebPtCnKp80XsEGi4woLo1Mw2lIHsSMwkpedNCdA5YTfajrfOWUM1V
   ZZvHFocWRLv3t3UEDypsDhUZ4ZQArK3JvKbQlzAdZxr5VL8EM9qpEemfD
   ZnRrz3SsJz67Ap8Yfmc49RnVyYZkh+s3cQaR7FbHYb+d8per+VQmgbVoW
   eu3D/whT1BEibCqZvjsONrm1l/HfIKctlkNGW4KhGbJwSF5c5Up27EXya
   SwGdpc/USze7A2JYnJ6s0UpxJ4V8sVmf+Q3YMeFACludFBqWeB8hP2PTq
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="319193627"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 09:52:28 +0800
IronPort-SDR: Epoc/Dk8OmxEaWyQGINaqprGtmzJZ7MWl63OuBdFXxJnK0LUtuNgdqV54J/LTLagYg+UcTd9gx
 lIc79YrMa/Tu2yrtKJShyowQxYX+kXBvkLAf8TBVWIkUvq/7yU90Jww+C9jwga6rD4zKA9xZyl
 tRr4ZcYTfExRNEo8fN5paFgLP0Hq2bcGAbCtQitm+TdwmDIvl8CbLn/Pmrqypo8HaVhlB7ESTW
 8iH/1NyF08CpaTcOKfHlccn5VipfkgVaypBfbPJGNRR8TwK8BkcO0i32a8yC+QMGt6bFrPeTc2
 dTugTcGlFFiaTb4aFukvIik+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 18:13:39 -0700
IronPort-SDR: 5wJYxWbTnVv9mDQg29GZeANZrK8JrO5BM5CQZ4eQUv/e1FUPCVJjzsxemJUuI8YXBYDJVCzOBX
 0bj2qJYF+XJaJTLJioHQMpBf91FIElltujGb7fIP2JAvrnq3918Uj69L/kToJoOgVHY7nloOtt
 PYiuSxupqzjyLnCxtVAtTmFcJYtpTh6kBdXHtHE1ELXLzMSbkhsvXr+X6N9yZFHayN4WWFCXpE
 /qPbeGhF3kpUHph07T2e3J8azZewUuEqVAN8AVyfcsc9i7bRbggmAOcBroOD1Qoi6eLbqNqArq
 mPw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 18:52:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtYYl3pPVz1Rws7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:52:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658973146; x=1661565147; bh=QVVBWQ6JmTLGyCI9T6RhLFvgwT91qI0IoKU
        t3pFI0/Q=; b=F2iFvoSMiJbccMADjVAZVn3gxWlhNSCpud0qSERpSOd0Ry5Xo6F
        81dY6m6tBCK2oCJXK4dOrRJS7yNisxUJtbfIfLOGG7EjrS5D/amN0FY+Hzj45R+L
        Oe5u5/l77XqslEMw0POtUwr7nVVYFzCyx/bcl3ycltBiovl0G1yxk50QbnjCapjx
        VG/XkGyfKk+WK613YwwwKpQXFZn+ty9vLUAVcqOYeXLtobUoJcygQwMnnLylXPYx
        RhXfOrxRLu3TdBEledwgd0z/EubL2m3Y60eLOH+lQW5gcXeEwhv7WiaAVoRGRAzO
        KZB8F0gXFZOk2ZhFee8Ub4lkhrskmA2GbIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y1ZkI4grDz1E for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 18:52:26 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtYYh12zFz1RtVk;
        Wed, 27 Jul 2022 18:52:23 -0700 (PDT)
Message-ID: <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 10:52:22 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
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

On 7/28/22 08:19, Bart Van Assche wrote:
> On 7/27/22 09:22, Pankaj Raghav wrote:
>> This series adds support to npo2 zoned devices in the block and nvme
>> layer and a new **dm target** is added: dm-po2z-target. This new
>> target will be initially used for filesystems such as btrfs and
>> f2fs that does not have native npo2 zone support.
> 
> Should any SCSI changes be included in this patch series? From sd_zbc.c:
> 
> 	if (!is_power_of_2(zone_blocks)) {
> 		sd_printk(KERN_ERR, sdkp,
> 			  "Zone size %llu is not a power of two.\n",
> 			  zone_blocks);
> 		return -EINVAL;
> 	}

There are no non-power of 2 SMR drives on the market and no plans to have
any as far as I know. Users want power of 2 zone size. So I think it is
better to leave sd_zbc & scsi_debug as is for now.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
