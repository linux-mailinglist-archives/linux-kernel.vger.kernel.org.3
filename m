Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A458FAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiHKKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiHKKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:43:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF388E993;
        Thu, 11 Aug 2022 03:43:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B90186601CE3;
        Thu, 11 Aug 2022 11:43:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660214592;
        bh=c783+yyvK/ZDieM0jMu1355LQscFY0xjpTvoVFq/DrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mm2wwWfOj2Tvnrkww/urAzpSz54KnWYXb7GcMDbbXDZRf2yLSZkYqQMEd2WawcdW8
         2i05kUTvE+QYNtckgD8EnHJxRElt2GIkcIfdEdV3K1Rdr2ZEvB5ghNlAD/XXTWPM/g
         C5UdskwnNIJ1zWo7R9x4JZvWEGvKbtHTrAdX4fkyLiiZWo7GY6+WO3oxnwkbigbRko
         50FnzVLUn2VHLji7iFxJD+vnNcoevtqg5KPXV3HQh/W6+DcN/TfdDSCvSb8hJQmmxG
         kirw5RLlo0hsllnJ7KUDuuz0sHEC9YwZt8dnwgC2FvQI3CFdL1ewSb37AqVq+GnALV
         +qBHNI7fyZlRg==
Message-ID: <e8b99943-d930-2d92-67ba-62ae17f7cd56@collabora.com>
Date:   Thu, 11 Aug 2022 13:43:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] iio: light: Add raw attribute
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        krisman@collabora.com, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220811101443.499761-1-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220811101443.499761-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 8/11/22 13:14, Shreeya Patel wrote:
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ltrf216a_set_power_state(data, true);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +		mutex_unlock(&data->lock);

ltrf216a_set_power_state(data, false) should be called before return.

> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		ltrf216a_set_power_state(data, false);


-- 
Best regards,
Dmitry
