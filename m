Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34D52CCFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiESH3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiESH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:29:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC9C8721B;
        Thu, 19 May 2022 00:28:59 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J5qka9024416;
        Thu, 19 May 2022 09:28:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HnzhgPXI0wRRfbcKCU/LITbeULiyLCcyHIVfQfy09hY=;
 b=jckhfWnVcR16DbhHd3LV2a9CJ4NEQBGnBpBwi5dJSOqJNPAJlHqc/0aEjCBmBI/n+1HV
 aIQHpWEi/7wxjOYAM5zrAEQTgtlc3GgktenVIkkpm7dKXNb7LqLsf7TiISwLmZUNHi6X
 NgzPIVRN+Aj/yu191VCzTb/+4DY9iTYdfTihP0mTnZ2IUAV1XNEpdLR9IpyaZG3p4D9M
 QoEh5ReOsWpD33eL4eomOotjNA2b1YZkaQl2OiQMx4Dnh3QapCABsgFJ8iuLs4/6ZhVO
 1RiGqMBGlufr1N0BEXXBk9Xn4r5qn1CK5znqwWuoHmNLz3zMR+HLQZ1OiwDSpXwKWZ+O qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23ahy521-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:28:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 947D410002A;
        Thu, 19 May 2022 09:28:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A1812128A4;
        Thu, 19 May 2022 09:28:32 +0200 (CEST)
Received: from [10.48.0.183] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 19 May
 2022 09:28:31 +0200
Message-ID: <c04a4e35-15ee-836b-1c9d-46a42abb05d1@foss.st.com>
Date:   Thu, 19 May 2022 09:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] media: stm32-dcmi: add support of 1X16 serial pixel
 formats variant
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
References: <20220516092048.264036-1-hugues.fruchet@foss.st.com>
 <20220516150237.v3xt7onp2lpmellw@uno.localdomain>
 <YoUoJRzStCnzhxUK@paasikivi.fi.intel.com>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <YoUoJRzStCnzhxUK@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari, Jacopo

Thanks for all !

On 5/18/22 19:08, Sakari Ailus wrote:
> Hi Jacopo,
> 
> On Mon, May 16, 2022 at 05:02:37PM +0200, Jacopo Mondi wrote:
>> Hi Hugues,
>>
>> On Mon, May 16, 2022 at 11:20:48AM +0200, Hugues Fruchet wrote:
>>> From: Hugues Fruchet <hugues.fruchet@st.com>
>>>
>>> Add support of 1X16 serial pixel formats in order to support
>>> CSI-2 camera sensor exposing 1x16 pixel formats only.
>>>
>>> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
>>
>> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
>>
>> Sakari, if you're sending a new pull request for the ov5640 series,
>> could you include this one as otherwise dcmi would be broken when used
>> with that sensor.
> 
> Just took this into my tree, with your refreshed ov5640 set.
> 
> Thanks!
> 

BR,
Hugues.
