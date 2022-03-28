Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6874E8CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 06:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiC1EJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 00:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiC1EJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 00:09:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BE4EF6A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648440482; x=1679976482;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=oxTyd3rceR0vk+a2kVnjlgDvw92SFnOgS7fo6r3xGyg=;
  b=DemGkzIT/smxuilSPlTUT6umb7szRw+kL6XhvzxlDJS1SxRMpThSq0hL
   5qtZ4FdWb4T2Bn/0fqNEiY2zYuzdZi9z6M4QMQu7XSjGhCFWQTzxa536t
   1xf10ddf8IyP5yelNkoLHpTFnlRrL5XgOiKxxVNh4EmXpf3FHydjS8M6t
   fX5t4HjGzftd0Waf3dRsVawQCaltTfilnqfrHZ8ZviI7BJN5TJYRx4vxe
   TffT393vKtEaQgDzRHk65OzR6PT9nrXil2MAvgW6WhipZ7r3RabRFBG+B
   csw/UXtCQiPMxmP8oYzyI5a//EY4tcU8f2qC8JASw+M0jtMV/x/fJnFf4
   g==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="308365150"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 12:08:02 +0800
IronPort-SDR: NUV24OTdnBwYyS9dQffn+jCfrFTRTB5T0CEVQnAqDUlTYqR3FCSPMswGVE/+FM82ln7kHvcU/a
 6RskyGyKlQ7uHZpqVpItGtU0bBH5Gu52BNtJl/tHPvFNuaxWF2WdMWD3LD1uvkCRpD21aIBhI2
 FcaZ7ce3wNPJNOSMqeeDFARQ+1Kob8ApydPMC70Bp4I954Ak0Q6Al8TS97FqA2pPCuVUMIeQcT
 A1OiJTOg+U5bvwAYHdpKgnwpfTQckq4E3RGUMKm9Yr25mQyfK5QYJRPsmAnweymQkSvRMG8E4l
 53MMuT+lo8JntvTPgfHiBZxz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 20:38:55 -0700
IronPort-SDR: wu+gXn2xcAUTQCoxYyBEWjYW7GpNU6ri0+HYVVlpL410LwIO1LWcofZj/QjCrgW1i77h6+Sm0q
 HnZWSy20nUNqH/XSeW96kasrVJvq0f/fhjpJfoud3bWbKMVMaP41nbLBlAp7npX4C0t4OmdT5u
 nNR9MsAL2wy6oVvSVaLLp3FCpS3669RM7rBa9uhEHSFao3rUpNe2enhqoDfxBsllLY3AaxviGR
 YeRZ+2SU7ecqirx78RTgZdI9fMPlrYnNNjpU4JCAUYR6pZnRqpXHN+aIW7cDbVATcEKIpUDBtA
 Cz4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 21:08:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRfLV0HkXz1SVp2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:08:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648440481; x=1651032482; bh=oxTyd3rceR0vk+a2kVnjlgDvw92SFnOgS7f
        o6r3xGyg=; b=r1TdfNgpBJ9Ir4clrvE2JsrJNnc4D9y1eV92c7t5rqiT/gH3Zcj
        R3HySJsZO+PyLwH2oia15Zzd70Iqy3Ak1GfknxjzmcLvD+skVe+mqQgAcPGBNLBG
        bTBKcKJ+vz9dFlWGLsjzyj3gsIerhue0zmJv8ynV9mkUD1Su4gICi24+EJHNyQVI
        2ZbqormjA753XjETi3cNdvYS8Qj1nFrC4KABZps2ENpzgk+PIMTam4WJlGjBMy1I
        Ob/VxoFX0HRv4fA2NANEcYC95t4P5cybh98QWpUGKA90WhWv3QARIm96zBELivy/
        sgaC0E5Yo5DcCSuZ5J+RFPgMdGUY+iPzwwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 17ZV-QKbqVCS for <linux-kernel@vger.kernel.org>;
        Sun, 27 Mar 2022 21:08:01 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRfLR56N9z1Rvlx;
        Sun, 27 Mar 2022 21:07:59 -0700 (PDT)
Message-ID: <222e0a61-d046-89fc-d46b-ac8da3ca7828@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 13:07:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fs: xfs: add NULL pointer check
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     cgel.zte@gmail.com, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, dchinner@redhat.com,
        chandan.babu@oracle.com, bfoster@redhat.com,
        allison.henderson@oracle.com, lv.ruyi@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20220328032642.2371596-1-lv.ruyi@zte.com.cn>
 <32fad707-fdab-75a6-f7e5-d356a0b86983@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <32fad707-fdab-75a6-f7e5-d356a0b86983@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 12:40, Damien Le Moal wrote:
> On 3/28/22 12:26, cgel.zte@gmail.com wrote:
>> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>>
>> kmem_zalloc() is a memory allocation function which can return NULL when
>> some internal memory errors happen. It is safer to check NULL pointer.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
>> ---
>>  fs/xfs/libxfs/xfs_attr_leaf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
>> index 014daa8c542d..e6694f49f563 100644
>> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
>> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
>> @@ -1571,6 +1571,8 @@ xfs_attr3_leaf_compact(
>>  	trace_xfs_attr_leaf_compact(args);
>>  
>>  	tmpbuffer = kmem_alloc(args->geo->blksize, 0);
> 
> See kmem_alloc() code: this function cannot fail (it retries the
> allocation until success). So checking for NULL pointer does not make sense.

Note: this comment is not 100% correct. kmem_alloc() can fail if
KM_MAYFAIL is specified as a flag. But that is not the case here.

> 
>> +	if (!tmpbuffer)
>> +		return;
>>  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
>>  	memset(bp->b_addr, 0, args->geo->blksize);
>>  	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
>> @@ -2290,6 +2292,8 @@ xfs_attr3_leaf_unbalance(
>>  		struct xfs_attr3_icleaf_hdr tmphdr;
>>  
>>  		tmp_leaf = kmem_zalloc(state->args->geo->blksize, 0);
>> +		if (!tmp_leaf)
>> +			return;
>>  
>>  		/*
>>  		 * Copy the header into the temp leaf so that all the stuff
> 
> 


-- 
Damien Le Moal
Western Digital Research
