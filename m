Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACE4E55F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiCWQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiCWQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:08:26 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B791706C;
        Wed, 23 Mar 2022 09:06:56 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22NEob0u010036;
        Wed, 23 Mar 2022 17:06:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=k0X50u6/n1u+2cH9IIPOPaW2XEKc9m24e0oZy5yoqzE=;
 b=IszIyvXsKzgByTrOGDy1n72xkh1IacPrHFxWOamEfJWHLyxpgsUGKddakNaqIii+t3D1
 gbkFZ8znFCi7sfLa1lZQGJFqAeNOEKuSeibVWQYay2f09Puzq5kBvio7nXshNkeufiaj
 nUq13LFQNTI4vxj5dBfthPq0JyaPfTuE5pj9JNrNfMygoPinh7a7QcI8EjJZ4ChUTP8q
 vkucgt1MdWAAGs+QFeNMgTo6chrfTMyAsHKIV7wpFB2Q9I/RvOU/YeGmmtJh/MBF7ecO
 5PjQWkfk83QHmN1XW0AF9Ge0cnmem+SUWDkZ8/Fl53pbVbyZnqNFfsdcItV7LlDMdngm yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ewr5g0q87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 17:06:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8663910002A;
        Wed, 23 Mar 2022 17:06:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 708F723BE0E;
        Wed, 23 Mar 2022 17:06:37 +0100 (CET)
Received: from [10.211.9.79] (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 23 Mar
 2022 17:06:36 +0100
Message-ID: <b99c7541-64d9-2c5e-8c66-bcf5a4ec00d7@foss.st.com>
Date:   Wed, 23 Mar 2022 17:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] brcmfmac: Avoid keeping power to SDIO card unless WOWL
 is used
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-wireless@vger.kernel.org>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        Christophe KERELLO - foss <christophe.kerello@foss.st.com>
References: <20220323083950.414783-1-ulf.hansson@linaro.org>
 <51b4917b-823d-263a-2412-a4b17cb38420@foss.st.com>
 <87a6dgk63l.fsf@kernel.org>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <87a6dgk63l.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_07,2022-03-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 17:04, Kalle Valo wrote:
> Yann Gautier <yann.gautier@foss.st.com> writes:
> 
>> On 3/23/22 09:39, Ulf Hansson wrote:
>>> Keeping the power to the SDIO card during system wide suspend, consumes
>>> energy. Especially on battery driven embedded systems, this can be a
>>> problem. Therefore, let's change the behaviour into allowing the SDIO card
>>> to be powered off, unless WOWL is supported and enabled.
>>>
>>> Note that, the downside from this change, is that during system resume the
>>> SDIO card needs to be re-initialized and the FW must be re-programmed. Even
>>> if this may take some time to complete, it should we worth it, rather than
>>> draining the battery.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Thanks for the patch, it is OK, and tested by Christophe (R.).
>> So you can add:
>> Tested-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> Acked-by: Yann Gautier <yann.gautier@foss.st.com>
> 
> Acked-by is used by the driver maintainer, so I assume you mean
> Reviewed-by?
> 
Oops, sorry, yes I meant Reviewed-by.

Best regards,
Yann
