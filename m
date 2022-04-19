Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A650764E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiDSRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244974AbiDSRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:17:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86413C3B;
        Tue, 19 Apr 2022 10:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CD5B816CA;
        Tue, 19 Apr 2022 17:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F796C385A5;
        Tue, 19 Apr 2022 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650388488;
        bh=mELWcw2sy0MMiNjuZqc4S/H0jeZKg3LDM5gQ37ppmTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0fTdrXa+xN84sGny+1DH9fIfghOFUvKiy8pIjWw7qu4S2j+sa64jrD/ICI/4VVTZa
         P936S3QT4ijD0Xv76BLvZLqJhfLigDgcZoB8LCQjxZXjHuCcbFyBRFsw98s6+wls7E
         HScLj1bIxF2e5jKv14AGTOm44yS2M4vdVzmotkYo=
Date:   Tue, 19 Apr 2022 19:14:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 05/11] platform/x86/intel/ifs: Read IFS firmware image
Message-ID: <Yl7uBWwobfYAWcIZ@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419163859.2228874-6-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:38:53AM -0700, Tony Luck wrote:
> +/*
> + * Load ifs image. Before loading ifs module, the ifs image must be located
> + * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
> + */
> +int load_ifs_binary(struct device *dev)

Shouldn't all of your global symbols start with "ifs_"?  Your other ones
seem to, what went wrong here?

Also, how about "ifs_load_firmware()" makes more sense.

thanks,

greg "naming is hard" k-h
