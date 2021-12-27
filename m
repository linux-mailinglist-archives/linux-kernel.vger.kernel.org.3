Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0629247FC99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhL0MZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:25:35 -0500
Received: from www381.your-server.de ([78.46.137.84]:40562 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhL0MZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=IDsW1D37Ld46xZP1e1BCxe9r4t30B4LlBb5BPXrT7To=; b=DUkJPJnEAWw/LmOdoNNgVO152V
        v/rQDMm1dfBoKJPa5RbuYo20KhUz1J9FsobvRK3FZOL3BGrV3bB6ZW5b5kJWI+if8zHxIyAydpq09
        vJGVN8sB9FuUPpJepWT/4ROdMv7hhmMi5PVGP/sPqfyrptZugp7ZBiZClgEmnKDcEXOF/lyZrPzdu
        Jf1Jb9pYf62AOJtlB/nSAvybnS6J7aa1XYJ8iHE576t9T/VtJKwaBGC6RikJlEjsG+KT72IslP351
        BC47EcpEo4keuhzXICiMhd5HS+m0jxdNGa1EPZ+Az3Q6y+MfvBXgGK8jl4da8eGHJQ+rbNmcOQ+Me
        7+aXTdUw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n1p4A-000BLW-B6; Mon, 27 Dec 2021 13:25:26 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n1p49-0005Te-ON; Mon, 27 Dec 2021 13:25:25 +0100
Subject: Re: [PATCH v2 00/23] counter: cleanups and device lifetime fixes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c8f6446e-748b-5845-ae60-5d6b8f3e8d39@metafoo.de>
Date:   Mon, 27 Dec 2021 13:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26404/Mon Dec 27 10:34:40 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 10:45 AM, Uwe Kleine-König wrote:
> [...]
>
>   - I wonder why counter is a bus and not a class device type. There is
>     no driver that would ever bind a counter device, is there? So
>     /sys/bus/counter/driver is always empty.
>
There used to be a time when GKH said that we do not want new driver 
classes. And all new subsystems should use bus since bus is a superset 
of class. This restriction has been eased since then.

But it was around when the IIO subsystem was merged and since the 
counter subsystem originated from the IIO subsystem I assume it just 
copied this.

