Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6FC47BEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbhLULMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:12:34 -0500
Received: from www381.your-server.de ([78.46.137.84]:50936 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhLULMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=y3MWVmCp4IRkq6xyrY/A4eXrUjdzp1WMmlbBYxWpWKA=; b=QofDzbsztPc29qGZbjjZr9M4qq
        dv2dd6AWsghoIzKpoJkhuJYGXN6Kz9REkp2qCVAskQE9z/pAXdI/fnIuEyTyCi/nZUnENaulCOXxG
        zpk/cKUN2jR6BFY4v5/AuXbi9r2GR5yYL3NkSmfIMhvYv/xKUqXFFWGCx2J2/EVPL9mYwF6ntYCVz
        QwIKVNaGJuwyAjfKNlfA4Mr4Qwwr7oIpWpidmAb1ZJAFocZ+6dRB1rPYmZdQKa8iiRuRnHSSzl719
        JaWF4NNp4P9LBTAotvzwECAqoL1CQSGO9hgYs+dcKOYNQMb79UO9+tJ2Ej53Ff2O5lsBFWJv5rLF6
        fglotcsQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mzd41-000DYW-B5; Tue, 21 Dec 2021 12:12:13 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mzd40-000FN1-VF; Tue, 21 Dec 2021 12:12:12 +0100
Subject: Re: [PATCH 0/8] counter: Remove struct counter_device::priv
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
Date:   Tue, 21 Dec 2021 12:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26395/Tue Dec 21 10:18:41 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 11:45 AM, Uwe Kleine-König wrote:
> Hello,
>
> similar to patch
> https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.1640072891.git.vilhelm.gray@gmail.com
> the usage of struct counter_device::priv can be replaced by
> container_of which improves type safety and code size.
>
> This series depends on above patch, converts the remaining drivers and
> finally drops struct counter_device::priv.

Not sure if this is such a good idea. struct counter_device should not 
be embedded in the drivers state struct in the first place.

struct counter_device contains a struct device, which is a reference 
counted object. But by embedding it in the driver state struct the life 
time of both the struct counter_device and and struct device are bound 
to the life time of the driver state struct.

Which means the struct device memory can get freed before the last 
reference is dropped, which leads to a use-after-free and undefined 
behavior.

The framework should be changed to rather then embedding the struct 
counter_device in the state struct to just have a pointer to it. With 
the struct counter_device having its own allocation that will be freed 
when the last reference to the struct device is dropped.

- Lars

