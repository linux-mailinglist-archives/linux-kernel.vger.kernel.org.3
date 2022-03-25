Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF314E6DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346798AbiCYF3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiCYF3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:29:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43128C558A;
        Thu, 24 Mar 2022 22:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E59D5B827DB;
        Fri, 25 Mar 2022 05:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDECDC340E9;
        Fri, 25 Mar 2022 05:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648186061;
        bh=o7srkXkXULFWKnfYW3Hq6LA5YW6Yx4lDlmCv1AtBwO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qgyNg2dHvREdN9Ag2cz2Kccs0yZa0IAIUxiIlV/d5bl+HIveB6M9WfyurSG0S7DXh
         FsuDKdLHox1YbEEr1ccbp9gqYEjOpSOhPdbWV9UxZB/FncV7MNG2oMLp756D83KBOk
         3MR4IuaJeOfFMp8jqjbTcSaS64w0CfKwajahLY/9n6nspk5/LJQ+4vXv/VUMtHDX6Z
         L9+MLth85+M+GIvw0sZE4jGw0TrggRzsywRXtbiZSE30C74yePCbDPN4CrSQXzXKXS
         k7gPcco9dZGYSP+/ar1ykKDwb/hzj66D7WVpSG7/S9CS32revZqFxWI15YvH1d5OcZ
         iuemKUYD3CsNw==
Date:   Fri, 25 Mar 2022 06:27:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20220325062735.0567775b@coco.lan>
In-Reply-To: <20220325085522.731aee73@canb.auug.org.au>
References: <20220301201659.45ac94cd@canb.auug.org.au>
        <20220324183329.22c97ea1@canb.auug.org.au>
        <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
        <20220324222241.42896e9e@canb.auug.org.au>
        <d1399c72-d729-58f8-ac63-1966f18c028d@redhat.com>
        <20220325085522.731aee73@canb.auug.org.au>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Mar 2022 08:55:22 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi Hans,
> 
> On Thu, 24 Mar 2022 14:04:28 +0100 Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > So I did some digging and the trick for reproducing any ABI
> > related warnings is to touch the .rst file which has the
> > "kernel-abi" reST directive (1) for the ABI subdir you want
> > to regenerate the ABI docs for.
> > 
> > So in this case I did:
> > 
> > touch Documentation/admin-guide/abi-testing.rst
> > make htmldocs &> log  
> 
> Looks like missing dependencies :-(

Not sure if are there a way to fix this. See, Sphinx doesn't use Makefile 
dependencies, but, instead, it checks if the .rst file has changed or not.
So, those tags that include contents from non-rst files, like the ABI ones
and kernel-doc tags, are not considered by Sphinx when detecting the need
to re-parse the .rst files that contain such tags.

The safest way to ensure that Sphinx will process everything is running
is to run `make cleandocs` before building the documentation.

> Thanks for persisting ad discovering this.
> 
> > And now I can see the warnings. I'll prepare a fix for this.  
> 
> Excellent, thanks.
> 
> > Looking at Documentation/Makefile I also learned that you
> > can also do this:
> > 
> > scripts/get_abi.pl validate --dir Documentation/ABI

No need to pass Documentation/ABI directory, as it assumes it per
default:

	$ scripts/get_abi.pl validate 

Warning: /sys/bus/iio/devices/iio:deviceX/fault_ovuv is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856:14  Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865:0
Warning: /sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865:12  Documentation/ABI/testing/sysfs-bus-iio:1943
Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  Documentation/ABI/testing/sysfs-bus-iio:91
Warning: /sys/devices/system/cpu/cpuX/topology/core_id is defined 2 times:  Documentation/ABI/testing/sysfs-devices-system-cpu:69  Documentation/ABI/stable/sysfs-devices-system-cpu:38

Btw, while here, you can also check if the new ABI definitions
are actually correct by running:

	$ ./scripts/get_abi.pl undefined

On a system where the new ABI "What:" definitions can be found.
This command converts the What: field into a regular expression,
and then check if the entries under sysfs actually match the 
location specified by the "What:" fields from the ABI files.

As there are currently many ones that are missing (or wrong), you
can limit the scope of the checks by adding --search-string <regex>,
like:

	$ ./scripts/get_abi.pl undefined --search-string hugepage
	/sys/kernel/mm/transparent_hugepage/defrag not found.
	/sys/kernel/mm/hugepages/hugepages-2048kB/free_hugepages not found.
	/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size not found.
	...
	/sys/kernel/mm/transparent_hugepage/khugepaged/full_scans not found.

> > Which results in a different set of warnings...  

Such warnings are also reported at build time, when the ABI file is
processed - e. g. if you either touch the files containing the ABI
.rst files or if you do a make cleandocs before building the 
documentation.

Thanks,
Mauro
