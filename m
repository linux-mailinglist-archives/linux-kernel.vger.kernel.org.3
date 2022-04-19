Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697B65067A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350374AbiDSJ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350398AbiDSJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:27:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A3BC9B;
        Tue, 19 Apr 2022 02:25:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id EC0CB1F42013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650360307;
        bh=a6llNOMgG5c9GRiJFktr/S/R/Vwl5cl+XkvWKZME0hA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=CqizTF9Ce2vQ2D/wegQIAIsidWCzd0dYTleYYRWjS5bJGSCyK7p222QRMRo70VD4a
         MqFb6L1xkC6A0CeUdU6t6a2ee3GUnKYUNm87HmitUbpN6YboUImDr3mheXL+ds/DTO
         kLE0FfxERhsuopC8fn06c0brC4LSL5dvTUGCcnti/ghH7PayrqGgyFdX5ER4naAOm9
         nlTGYlAkbbFdBeERWZArDhMysZdxBeSKDC8bpL9DwGjdVvYrx2MgSVsYaFUkFWnw9r
         fsjFuF6SY+ZywUlUhnuN2A4b6z9+3y71gneiSkJV1BxbEjDWY42aPJbY0ZB3SB7thT
         vBujHncmIFAXw==
Message-ID: <a6d6484d-583b-c5f3-bc3e-3a87037b9716@collabora.com>
Date:   Tue, 19 Apr 2022 14:24:55 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
 <eygNMwL4gadqjJuOq-syanavJ5sAb5_dHTcQ0V9TU5kM5uh5TZUQXdYsNFTtnSm1ZI5WKhw7BgzG8lXEwJKEZz4agWq5_HkFDGWiFuuo7fE=@protonmail.com>
 <78e3e1e9-e21f-052a-ecff-1d13714b4303@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <78e3e1e9-e21f-052a-ecff-1d13714b4303@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 10:31 PM, Muhammad Usama Anjum wrote:
> Hi,
> 
> Thanks for reviewing.
> 
>>> +	switch (element->type) {
>>> +	case ACPI_TYPE_BUFFER:
>>> +		length = element->buffer.length;
>>> +		info->data = kmemdup(element->buffer.pointer,
>>> +				     length, GFP_KERNEL);
>>> +		break;
>>> +	case ACPI_TYPE_INTEGER:
>>> +		length = snprintf(buffer, sizeof(buffer), "%d",
>>> +				  (int)element->integer.value);
>>> +		info->data = kmemdup(buffer, length, GFP_KERNEL);
>>
>> You can use `kasprintf()` here, no?
>>
Yeah, I can use sasprintf() in place of snprintf() and kmemdup(). Thanks.

> Choosing kmemdup vs k*printf depends on what is being achieved. Usage of
> kmemdup indicates that only the memory is being duplicated here. While
> in case of k*printf, some transformation is done. Thus in normal memory
> duplication cases like this, the usage of kmemdup makes code more
> readable and seems preferable to me.
> 

-- 
Muhammad Usama Anjum
