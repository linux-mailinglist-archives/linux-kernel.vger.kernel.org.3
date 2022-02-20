Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8B4BCEEE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbiBTOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:06:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiBTOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:06:20 -0500
X-Greylist: delayed 933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 06:05:54 PST
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F07145ADF;
        Sun, 20 Feb 2022 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=MZoKb9hkNy/YztJH3jvZm9vX6HmaFd7kAfLYZurpauA=; b=a8zes3mxnr/TOyTPcpl0nLcQ6H
        uv2+tS8gusHLD+d2ffEPstRMlA3g9WBeDnVDwJqY1JSOmzx4+e4FK/IMy6r9aDhzzamvpeoByiojl
        bh3Ta4EPsHbsTqOEheeLYoZVQAWOukImlI3boNy2daoocd/ZcSZ6fzBY7a47nbImQIsk4oV3lgZGK
        /eG4HqADjHCm20tmUkUK41FtUUHE5KKGTS04JM6TjxBhIUhzn+zghyVFKkF7VjCaJM+UHKt3v1+i2
        1+MyM5aFpHSxey2JqZ4HmtcglLt8JfjwZ9rwuuzqbwk8W6Z1rrbi7cVTtviXHMSshcqr4M6Ppd4eE
        tT4ZfVAA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nLmbS-000DRK-Gf; Sun, 20 Feb 2022 14:50:18 +0100
Received: from [62.216.202.16] (helo=[192.168.178.36])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nLmbS-000C96-21; Sun, 20 Feb 2022 14:50:18 +0100
Message-ID: <0a606181-b51b-526a-7166-2f2a362dc8d6@metafoo.de>
Date:   Sun, 20 Feb 2022 14:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] iio: core: provide a default value `label` property
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Nandor Han <nandor.han@vaisala.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220216135604.3435769-1-nandor.han@vaisala.com>
 <20220220131809.1bc184e0@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220220131809.1bc184e0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26459/Sun Feb 20 10:22:37 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 14:18, Jonathan Cameron wrote:
> On Wed, 16 Feb 2022 15:56:04 +0200
> Nandor Han <nandor.han@vaisala.com> wrote:
>
>> The label property is used to correctly identify the same IIO device
>> over reboots. The implementation requires that a value will be provided
>> through device-tree. This sometime could requires many changes to
>> device-trees when multiple devices want to use the label property.
>> In order to prevent this, we could use the device-tree node
>> name as default value. The device-tree node name is unique and
>> also reflects the device which makes it a good choice as default value.
>> This change is backward compatible since doesn't affect the users that
>> do configure a label using the device-tree or the ones that are not
>> using the labels at all.
>>
>> Use the device-tree node name as a default value for `label` property,
>> in case there isn't one configured through device-tree.
> Interesting idea.  However a few concerns come to mind.
> 1) If we start having a default for this, then it will get used as ABI
>     and if a label is applied later to the DT then we will end up breaking
>     userspace scripts.
> 2) If we do this it should be firmware agnostics (we need to fix
>     the existing code to be such as well).
> 3) Is the node name always unique (think multiple accelerometers on
>     different i2c masters)?
> 3) I'm fairly sure this information is readily available anyway.
>     either via the of_node link for the iio\:deviceX
>     So why not have your usespace use that instead of label?
>     I'm not a fan of duplicating information that is readily available
>     anyway - be it as name and reg in the of_node directory.

I'm not a big fan of this either for the above reasons.


