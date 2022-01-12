Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA6348C40F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbiALMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240219AbiALMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641990811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86h8CwPQPMIrhzzEiKJNUVRKLUq1ncybMybMxirp2aU=;
        b=C3uxInoB5UJD5yv5Ocy+GtQvzUmc4DPa3fo/Jr+ujmzhJav94T7FlewecHNa22ICj9Gysd
        l8rtqFicZxfBou8CcbJeiOaulitOQ9jgEVy1KzxrFd4VEkN+duojc4X7IdJLtRljsm3isL
        h7tummHmfR6/UtM/1ZLAdVHdmg1TzOc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-ThvQdb5VMdi8f3C1R_-v_A-1; Wed, 12 Jan 2022 07:33:30 -0500
X-MC-Unique: ThvQdb5VMdi8f3C1R_-v_A-1
Received: by mail-ed1-f70.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so2162790edz.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=86h8CwPQPMIrhzzEiKJNUVRKLUq1ncybMybMxirp2aU=;
        b=Joju2XNjIKE47sUp82etsstdtS5CrbVwuR3FaTwrTcdxyGEz9aSFyMv7AsnAgszMpS
         RcjvgfOlPPZZ/6+nP7LgRDvKZNWEKNThzwl9l2kXTGEQyCKla3YRdBCyAZwSK32lIt2y
         d+VX9TYWmgg5rQwe5Hw9NTdOyshDVqt0szJPCn6EQxuV5qu2wjZ7ThkCUKgloud1l5w8
         pvvIdaF88nPSEQRiKWoiYe4u7gtZDGansA43gqanB0bh85hDBj2DiUSbjHIlCq5gkO4B
         qtQPnmHq10qg2SstGE47UH5JqTnn9ifZbwqMvXGrrCTUziZvSRHSKrfyNSm4HZAHVaG+
         fY9w==
X-Gm-Message-State: AOAM531ZYlTen8VK2FSTSx2pT+DW+oIGSsShby5wDrHj9PRG+53fey4b
        Gty2ywzZZP8RrJJJAthSSCslrKPMUlQXo3Zwr+NJcidH16O5VMAtN8SLJS+y7vDO2G94wiPgtQP
        aKUlto3wLCmYpVDZtt3rsINA9
X-Received: by 2002:a17:906:9f06:: with SMTP id fy6mr4739829ejc.38.1641990809092;
        Wed, 12 Jan 2022 04:33:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUFdB9Pa3Ubqwb8xawYhNP+GITG9uWRJ1R+Hx1+LprehkzN7Pb+68pKWDGU2VrqYPQfNhKuA==
X-Received: by 2002:a17:906:9f06:: with SMTP id fy6mr4739820ejc.38.1641990808904;
        Wed, 12 Jan 2022 04:33:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id z11sm6089208edr.72.2022.01.12.04.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 04:33:28 -0800 (PST)
Message-ID: <7e897fe1-10ba-85ca-dfda-183454177730@redhat.com>
Date:   Wed, 12 Jan 2022 13:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/3] ACPI: scan: acpi_scan_init() updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <11903300.O9o76ZdvQC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <11903300.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/11/22 17:45, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are some minor defects in acpi_scan_init() and because recent changes
> cause static checkers to catch them, it is better to address them right away.
> 
> Please see patch changelogs for the details.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

