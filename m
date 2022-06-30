Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48A562379
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiF3TuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiF3TuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:50:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94543EC8;
        Thu, 30 Jun 2022 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656618611; x=1688154611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mgNoeNK5FwsE3dL2orn06BOynHIf61d+JfoFhu8+8Ls=;
  b=ktEKEMQE0aL749xNj4MVVEkqizA0va1RG3vXEoZxb0OgCi7xbMZxGivy
   nY2UfgORxpkGoPwz1IiLVMMOv2EqE11ANSYwojs1sFbq42drKGaKF+IRP
   7eUUjb6ngFaK1mIYGUO61cn6PmbeIWS+JIIsdV8DuDrDEu02zwiSVwZ4U
   aWY2dfKNIru536gwN9U5i5XCSNxcs8Tvuhl9TqbSPuNezJShSP3fbUoMx
   nPFdbMTsRKfZVOfWvUYmQIIzJvRCz99w0jwU9XHbYovvEpYNR0K93KLWM
   qsvsjbVxbHpjn9xJDTdDzA02adB6r31wpIfdQ75jub+A7baVmeM7tyPKj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="344136452"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="344136452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:50:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="618093333"
Received: from jhilliar-mobl.amr.corp.intel.com (HELO [10.212.10.157]) ([10.212.10.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:50:10 -0700
Message-ID: <b080405b-d1af-8a32-a429-b09250489f0c@linux.intel.com>
Date:   Thu, 30 Jun 2022 14:50:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to
 identify firmware
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        alsa-devel@alsa-project.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>
References: <20220630150135.1799535-1-sbinding@opensource.cirrus.com>
 <20220630150135.1799535-3-sbinding@opensource.cirrus.com>
 <2cc37f6d-72a7-9064-cad2-c6c6d21ede61@linux.intel.com>
 <Yr36wcXf1/bNS0a3@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Yr36wcXf1/bNS0a3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 14:34, Mark Brown wrote:
> On Thu, Jun 30, 2022 at 01:35:05PM -0500, Pierre-Louis Bossart wrote:
> 
>> It's my understanding that the _SUB method is optional, not required. It
>> may be wise to plan for a fallback, e.g to use DMI quirks or other
>> identifiers, no?
> 
> Presumably the fallback would go into cs35l41_acpi_get_name()?

That's what I had in mind, if this _SUB does not exist then you could
use something else instead of returning -ENODATA;

+	sub = acpi_get_subsystem_id(handle);
+	if (IS_ERR(sub))
+		return PTR_ERR(sub);
+
+	cs35l41->dsp.system_name = sub;
