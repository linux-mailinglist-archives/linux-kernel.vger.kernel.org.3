Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A1B5450AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiFIPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344490AbiFIPXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:23:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16A2F1D;
        Thu,  9 Jun 2022 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788209; x=1686324209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SOwvpVCZjkxg8KZs0RVxDzu9voSyzOt3EM4EtxcOcNc=;
  b=ZP7VNAPSJ9y9gSklyP/Y3S/rHjVxM8tRF9qVSdvPUL0q5slk9iLHX53y
   urx+gAz9HmeSlNieQ7IGO4qr1zBZuh6SpQhRebOVtzJzSkt7Mbfk93B7p
   EvEpzWOG3NeM5RdBZcO8g6jDQtCD3nXuvisTdvSC4uG5vtuVzcLnyKrmb
   8rroQRzoM0sIpwo2w75cOj5Vng5PEC3hgJfnZ/juWRQSDx1g+BtZ1+VfK
   cx4kDH2C5vvEyq8Av+/POQRkxah6hF3PBFiQfPlfRHteSip3wMwSPboP8
   DVT6enK1kuykwbNpiTu5UXrTieosFtqDkaXp7uyYGorCmWsgH1g8n5OID
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257747939"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257747939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:23:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585630730"
Received: from jeremywe-mobl3.amr.corp.intel.com (HELO [10.209.173.145]) ([10.209.173.145])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:23:28 -0700
Message-ID: <63d7f3ed-b5a9-c869-5d25-a33a1d4e63c8@linux.intel.com>
Date:   Thu, 9 Jun 2022 10:22:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v1 14/16] soundwire: Use acpi_dev_for_each_child()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1843211.tdWV9SEqCh@kreacher> <5296779.Sb9uPGUboI@kreacher>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <5296779.Sb9uPGUboI@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rafael. This looks mostly good but I have a doubt on the error
handling, see below.

> +static int sdw_acpi_check_duplicate(struct acpi_device *adev, void *data)
> +{
> +	struct sdw_acpi_child_walk_data *cwd = data;
> +	struct sdw_bus *bus = cwd->bus;
> +	struct sdw_slave_id id;
> +
> +	if (adev == cwd->adev)
> +		return 0;
> +
> +	if (!find_slave(bus, adev, &id))
> +		return 0;
> +
> +	if (cwd->id.sdw_version != id.sdw_version || cwd->id.mfg_id != id.mfg_id ||
> +	    cwd->id.part_id != id.part_id || cwd->id.class_id != id.class_id)
> +		return 0;
> +
> +	if (cwd->id.unique_id != id.unique_id) {
> +		dev_dbg(bus->dev,
> +			"Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> +			cwd->id.unique_id, id.unique_id, cwd->id.mfg_id,
> +			cwd->id.part_id);
> +		cwd->ignore_unique_id = false;
> +		return 0;
> +	}
> +
> +	dev_err(bus->dev,
> +		"Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> +		cwd->id.unique_id, id.unique_id, cwd->id.mfg_id, cwd->id.part_id);
> +	return -ENODEV;

if this error happens, I would guess it's reported ....

> +}
> +
> +static int sdw_acpi_find_one(struct acpi_device *adev, void *data)
> +{
> +	struct sdw_bus *bus = data;
> +	struct sdw_acpi_child_walk_data cwd = {
> +		.bus = bus,
> +		.adev = adev,
> +		.ignore_unique_id = true,
> +	};
> +	int ret;
> +
> +	if (!find_slave(bus, adev, &cwd.id))
> +		return 0;
> +
> +	/* Brute-force O(N^2) search for duplicates. */
> +	ret = acpi_dev_for_each_child(ACPI_COMPANION(bus->dev),
> +				      sdw_acpi_check_duplicate, &cwd);
> +	if (ret)
> +		return ret;

... here, but I don't see this being propagated further...

> +
> +	if (cwd.ignore_unique_id)
> +		cwd.id.unique_id = SDW_IGNORED_UNIQUE_ID;
> +
> +	/* Ignore errors and continue. */
> +	sdw_slave_add(bus, &cwd.id, acpi_fwnode_handle(adev));
> +	return 0;
> +}
> +
>  /*
>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>   * @bus: SDW bus instance
> @@ -135,8 +200,7 @@ static bool find_slave(struct sdw_bus *b
>   */
>  int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  {
> -	struct acpi_device *adev, *parent;
> -	struct acpi_device *adev2, *parent2;
> +	struct acpi_device *parent;
>  
>  	parent = ACPI_COMPANION(bus->dev);
>  	if (!parent) {
> @@ -144,52 +208,7 @@ int sdw_acpi_find_slaves(struct sdw_bus
>  		return -ENODEV;
>  	}
>  
> -	list_for_each_entry(adev, &parent->children, node) {
> -		struct sdw_slave_id id;
> -		struct sdw_slave_id id2;
> -		bool ignore_unique_id = true;
> -
> -		if (!find_slave(bus, adev, &id))
> -			continue;
> -
> -		/* brute-force O(N^2) search for duplicates */
> -		parent2 = parent;
> -		list_for_each_entry(adev2, &parent2->children, node) {
> -
> -			if (adev == adev2)
> -				continue;
> -
> -			if (!find_slave(bus, adev2, &id2))
> -				continue;
> -
> -			if (id.sdw_version != id2.sdw_version ||
> -			    id.mfg_id != id2.mfg_id ||
> -			    id.part_id != id2.part_id ||
> -			    id.class_id != id2.class_id)
> -				continue;
> -
> -			if (id.unique_id != id2.unique_id) {
> -				dev_dbg(bus->dev,
> -					"Valid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> -					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
> -				ignore_unique_id = false;
> -			} else {
> -				dev_err(bus->dev,
> -					"Invalid unique IDs 0x%x 0x%x for Slave mfg_id 0x%04x, part_id 0x%04x\n",
> -					id.unique_id, id2.unique_id, id.mfg_id, id.part_id);
> -				return -ENODEV;
> -			}
> -		}
> -
> -		if (ignore_unique_id)
> -			id.unique_id = SDW_IGNORED_UNIQUE_ID;
> -
> -		/*
> -		 * don't error check for sdw_slave_add as we want to continue
> -		 * adding Slaves
> -		 */
> -		sdw_slave_add(bus, &id, acpi_fwnode_handle(adev));
> -	}
> +	acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);

... here?

It looks like a change in the error handling flow where
sdw_acpi_find_slaves() is now returning 0 (success) always?

Shouldn't the return of sdw_acpi_find_one() be trapped, e.g. with

return acpi_dev_for_each_child(parent, sdw_acpi_find_one, bus);

>  
>  	return 0;
>  }
> 
> 
> 
