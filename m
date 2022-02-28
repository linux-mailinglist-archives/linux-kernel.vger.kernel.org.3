Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08B54C6A93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiB1LfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiB1Le5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:34:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304A42EFE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:34:18 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21S94Zq0026184;
        Mon, 28 Feb 2022 05:34:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=S6VCir7jm3q0cll/4S/bnJ/UG0+NhIM5qnTgg96Qo9c=;
 b=B0M8L6iA7FaWOI/McUkx+liiX8uATngvbqJ3GwwIQLjaW+vUVoHbFYMX+K3wK9HDpx9D
 eVlb/+s647FDxCQEPRs6hQWJOiEdM8JFhPkkylAJ/EmQRtAk3oGqVeC0UjBxssZKp6y4
 c5sk5/yCUV+EF9+otISApzHJCmKRzbMW4fNtGrmubCEna2uwnWO+1V8Lza3y6d/go7y5
 VTOFE9IGDxvZj6XelIeVbcXtw+r/VUZjFfX54NrUDOrQMLdbys/GGGbidxw7jNCRY5R9
 mobU4LXBL+lQMa7oZ3UAiEyw2SOj30Dq55hCGSFUyah1JG+uHdAe3g66DXgs9njF35hA kw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3efhgsa587-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Feb 2022 05:34:15 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 11:34:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 28 Feb 2022 11:34:13 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 93653B06;
        Mon, 28 Feb 2022 11:34:13 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:34:13 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mfd: arizona-spi: Split Windows ACPI init code into
 its own function
Message-ID: <20220228113413.GI38351@ediswmail.ad.cirrus.com>
References: <20220223134222.730886-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220223134222.730886-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: SDrrRuWcxLDQ178bc1tBPyagi4z6VqXe
X-Proofpoint-ORIG-GUID: SDrrRuWcxLDQ178bc1tBPyagi4z6VqXe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:42:21PM +0100, Hans de Goede wrote:
> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> Android as factory installed OS.
> 
> The ACPI fwnode describing the codec differs depending on the factory OS,
> and the current arizona_spi_acpi_probe() function is tailored for use
> with the Windows board ACPI tables.
> 
> Split out the Windows board ACPI tables specific bits into a new
> arizona_spi_acpi_windows_probe() function in preparation for also
> adding support for the Android board ACPI tables.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
