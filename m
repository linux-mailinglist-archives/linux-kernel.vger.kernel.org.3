Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A1348C4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbiALNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:18:23 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238028AbiALNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:18:21 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CBDTFE023994;
        Wed, 12 Jan 2022 14:18:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=T7flA1KHr7bxUHl76iX93w+upbHvsWFpRfz43ZOMylQ=;
 b=aPv+FaTvaYpTOAVTZuEnK+KOlsuAuBibWtoqGHI7QPb7LKQQaskm70Wi0MkS/mhhm0tt
 RV0LbVhNLek/KGNCXgk2dZqiWtZjtcSo16XsVYYkQxUcW3zut7Vq1gkawC2Ui75RP6IS
 GqJcTPHKjuYJyzI9om2w6s3xYyBlYzSfdj7NNNId8X5Esrc2Z9q5FpWaVAGlVQSOHvsN
 bC4gC93RguezUTIsO6W//PeGNiLpri9/G5lCvAZzNxrR42AcpmbTPJYf5X0xGuzfNSin
 k2d0Z0OIHVEQAwpobHZfi0HpAVySnzRM3tE54u/HMN3f7kz9KIdILgEpNBGIozexww0u iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dh9cbeedd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 14:18:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58F6D10002A;
        Wed, 12 Jan 2022 14:18:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D5EE231523;
        Wed, 12 Jan 2022 14:18:02 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 12 Jan
 2022 14:18:01 +0100
Subject: Re: spi: stm32-qspi: Update spi registering
To:     Mark Brown <broonie@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20220106132052.7227-1-patrice.chotard@foss.st.com>
 <Ydbz2JkT8jRvNBBZ@sirena.org.uk>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <dda713f1-165b-0877-5467-457805fb9d43@foss.st.com>
Date:   Wed, 12 Jan 2022 14:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ydbz2JkT8jRvNBBZ@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On 1/6/22 2:51 PM, Mark Brown wrote:
> On Thu, Jan 06, 2022 at 02:20:52PM +0100, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Replace devm_spi_register_master() by spi_register_master() to ensure
>> that spi sub-nodes are unregistered in the correct order when qspi driver
>> is removed.
> 
> This commit message doesn't describe the actual issue.  The change is
> fixing ordering within the driver itself - the driver is freeing things
> in the remove() callback which are used by the controller but thanks to
> the use of devm the controller isn't unregistered from the core until
> after the remove() callback has run so we might still have something
> running.  "Subnodes" aren't an issue here.

OK i will update this comment to be clearer.

> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
> 

Agree, i forgot to use the correct script to submit patches to ML.

Thanks
Patrice
