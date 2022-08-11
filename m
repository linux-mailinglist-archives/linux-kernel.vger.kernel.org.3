Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB558FAED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiHKKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiHKKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:51:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD37820B;
        Thu, 11 Aug 2022 03:51:12 -0700 (PDT)
Received: from [IPV6:2405:201:10:389d:42df:ae4c:c047:294c] (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82B106601CE2;
        Thu, 11 Aug 2022 11:51:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660215071;
        bh=IfPooe1VNkTtfiNR2zb1X1udyCJ5qiqVzbKpp7Jtf/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AzSDrxaBlb/8Z/b1yo7GpOsQOvjwXnAJgnSWybI2ANSb3PhK3MHmB80N5c8Eu6wMb
         py9MTrBrshMuimJuvgjWQYc1Hof7xpA0JXiLDsx1TVMfQTAh7j6sbzWiUdZyN4ZsTW
         e9dvKduYfx7W1MjkLB+I4kA6mCMLCX1UEouuS/HL//iCatP2ebA34qKOvoa5ge7fIK
         gAWQRvdMt8OGHuSEc9Ba2d7yIq5qVyVoUxJrtXmh+et2UEHA5UddanxjB1MyDPPjZ6
         uLQLvG5JyCGz5dsEAtxVUcdU/qwq2wX5N7LN5IANqmzi4xctXsRmNBOcDRLvwsP465
         VQapnZyFSxxNQ==
Message-ID: <fa583bc3-bb43-2788-3c83-479859c40b75@collabora.com>
Date:   Thu, 11 Aug 2022 16:21:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iio: light: Add raw attribute
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        krisman@collabora.com, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220811101443.499761-1-shreeya.patel@collabora.com>
 <e8b99943-d930-2d92-67ba-62ae17f7cd56@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <e8b99943-d930-2d92-67ba-62ae17f7cd56@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/08/22 16:13, Dmitry Osipenko wrote:
> On 8/11/22 13:14, Shreeya Patel wrote:
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = ltrf216a_set_power_state(data, true);
>> +		if (ret)
>> +			return ret;
>> +		mutex_lock(&data->lock);
>> +		ret = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
>> +		mutex_unlock(&data->lock);
> ltrf216a_set_power_state(data, false) should be called before return.

ah! yes, missed that. Thanks for pointing out. I'll send a v2.


Thanks,
Shreeya Patel

>> +		if (ret < 0)
>> +			return ret;
>> +		*val = ret;
>> +		ltrf216a_set_power_state(data, false);
>
