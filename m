Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165B054465F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbiFIIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbiFIIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:46:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BD14768B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23686B82C7B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BFFC34114;
        Thu,  9 Jun 2022 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764257;
        bh=3hObGWWzQZpFXvDPW5fCAcwb9Jy8tx9LjTKwNDUJr1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK5/r8u4v5tOYCLkflFk6wwMIP0XY8kMSENnRIzo1TkrjWgWLGBoflvpZwkGVOsvL
         BKvsiyEvXdC/Xa759LsZnPUZ53DSqrSvcnXhekRSNzUj3a0BDiJzKUxF9AZ2nSdDFN
         EXHwZv2CPqKNryZuSmiv/nWSMKvxDs8KlBgVVdCTWMsOhPUgfClHvg9ZDi9v+0T3S1
         2ta9TbXecWAEVBl3XfRatCNDUysL3976VCDe5X7N/cbk9kkDbBkq9SEySzLphn4hkm
         JhYVGiO2cw8DqdHE2jEwU/PxBlSKYIcVDa3Lp5nyLdLvViZfbgiHvXA4UXECllHh0/
         XtoMxTyO2JKBA==
Date:   Thu, 9 Jun 2022 08:44:14 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 16/23] platform/chrome: cros_ec_proto: return 0 on
 getting cmd mask success
Message-ID: <YqGy3v5Vpb8/79XA@google.com>
References: <20220608110734.2928245-1-tzungbi@kernel.org>
 <20220608110734.2928245-17-tzungbi@kernel.org>
 <CABXOdTd76gczEimVxqWFmyHtbjG=dqALcGcudfZJrUd7qKcVfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTd76gczEimVxqWFmyHtbjG=dqALcGcudfZJrUd7qKcVfA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:20:29AM -0700, Guenter Roeck wrote:
> On Wed, Jun 8, 2022 at 4:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > cros_ec_get_host_command_version_mask() used to return value from
> > send_command() which is number of available bytes for input payload on
> > success (i.e. sizeof(struct ec_response_get_cmd_versions)).
> >
> > However, the callers don't need to know how many bytes are available.
> >
> > Don't return number of available bytes.  Instead, return 0 on success;
> > otherwise, negative integers on error.
> >
> > Also remove the unneeded `ver_mask` initialization as the callers should
> > take it only if cros_ec_get_host_command_version_mask() returns 0.
> 
> Make sure this compiles with W=1. Compilers may think that ver_mask
> may be uninitialized when used.

If I tested it correctly, it compiles.

$ make mrproper
$ make allmodconfig
$ make W=1 drivers/platform/chrome/
...
  CC      drivers/platform/chrome/cros_ec_proto.o
  CC      drivers/platform/chrome/cros_ec_trace.o
  AR      drivers/platform/chrome/built-in.a
  CC [M]  drivers/platform/chrome/chromeos_acpi.o
  CC [M]  drivers/platform/chrome/chromeos_laptop.o
  CC [M]  drivers/platform/chrome/chromeos_privacy_screen.o
  CC [M]  drivers/platform/chrome/chromeos_pstore.o
  CC [M]  drivers/platform/chrome/chromeos_tbmc.o
  CC [M]  drivers/platform/chrome/cros_ec.o
...
