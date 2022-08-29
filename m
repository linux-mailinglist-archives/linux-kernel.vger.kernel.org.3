Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4E5A4225
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiH2FN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2FNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:13:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E963422F5;
        Sun, 28 Aug 2022 22:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661750030; x=1693286030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfTTN8fVVmqUhF1jQjcmRJRxUTSzT6rPsDhYFizdeYE=;
  b=mnPOzLekELSKI91CFFZA86EJUW93Gt+m9E97YW5a0ghsasqi2eRJWJIZ
   abdmHscEd4/mBWFO26xhoVAwfksJGbuNzXt+FALlcJmACjFqvxK3Ibb9G
   Vt/ZArtxTb7v7aUeQj7cJheVbFPEFteTyE0jfIAvhrsfhl7c/kFuLHhLz
   7blUfZ3j4SzVUxqLdh7Gjrzz/tjzwF4NxvR5sAsoTuzUl3S8qNeMoR2Qy
   ECaLJNK6STJCcrXYrFY3BSjuOfcXAQrOCGzq1p11afvZyRX7u6TQ1ISa0
   P7qrou6TDomPTHon7rKQtTwIqq3wJckLuqzz6kF4a/doxRChB0UkUmk6R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="274558757"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="274558757"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 22:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="939443235"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2022 22:13:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EC602AD; Mon, 29 Aug 2022 08:13:46 +0300 (EEST)
Date:   Mon, 29 Aug 2022 08:13:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
        hdegoede@redhat.com, Shyam-sundar.S-k@amd.com, nakato@nakato.io
Subject: Re: [PATCH v1] drivers/acpi/x86: check return null pointer from
 acpi_evaluate_dsm()
Message-ID: <YwxLCtMCncW3j7iE@black.fi.intel.com>
References: <20220828205120.1956222-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828205120.1956222-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 28, 2022 at 01:51:20PM -0700, Li Zhong wrote:
> From: lily <floridsleeves@gmail.com>
> 
> Check return value from acpi_evaluate_dsm(). Only do ACPI_FREE() when
> out_obj is not NULL pointers.

ACPI_FREE() expands to kfree() and that allows NULL pointers so I don't
think this patch is necessary.
