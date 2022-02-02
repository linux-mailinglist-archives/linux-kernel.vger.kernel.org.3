Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411434A7036
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiBBLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:43:21 -0500
Received: from foss.arm.com ([217.140.110.172]:53300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343974AbiBBLnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:43:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3865F1FB;
        Wed,  2 Feb 2022 03:43:19 -0800 (PST)
Received: from [10.57.89.81] (unknown [10.57.89.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CC113F40C;
        Wed,  2 Feb 2022 03:43:17 -0800 (PST)
Message-ID: <fca634ba-a05a-10e3-4c12-8774c49a91fe@arm.com>
Date:   Wed, 2 Feb 2022 11:43:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] hwtracing: coresight: Replace acpi_bus_get_device()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
References: <5790600.lOV4Wx5bFT@kreacher>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <5790600.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael

On 01/02/2022 17:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/hwtracing/coresight/coresight-platform.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/hwtracing/coresight/coresight-platform.c
> ===================================================================
> --- linux-pm.orig/drivers/hwtracing/coresight/coresight-platform.c
> +++ linux-pm/drivers/hwtracing/coresight/coresight-platform.c
> @@ -626,7 +626,7 @@ static int acpi_coresight_parse_link(str
>   				     const union acpi_object *link,
>   				     struct coresight_connection *conn)
>   {
> -	int rc, dir;
> +	int dir;
>   	const union acpi_object *fields;
>   	struct acpi_device *r_adev;
>   	struct device *rdev;
> @@ -643,9 +643,9 @@ static int acpi_coresight_parse_link(str
>   	    fields[3].type != ACPI_TYPE_INTEGER)
>   		return -EINVAL;
>   
> -	rc = acpi_bus_get_device(fields[2].reference.handle, &r_adev);
> -	if (rc)
> -		return rc;
> +	r_adev = acpi_fetch_acpi_dev(fields[2].reference.handle);
> +	if (!r_adev)
> +		return -ENODEV;
>   

Is this patch part of a series ? I don't see acpi_fetch_acpi_dev()
in v5.17-rc1, which our tree is based on at the moment. Please could
you point us to the changes ?

Also do you expect to pull this via your tree ?

Cheers
Suzuki

>   	dir = fields[3].integer.value;
>   	if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> 
> 
> 

