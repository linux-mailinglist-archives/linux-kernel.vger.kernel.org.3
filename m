Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDC58F780
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiHKGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKGUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C13283BE5;
        Wed, 10 Aug 2022 23:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D548D6144E;
        Thu, 11 Aug 2022 06:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86CBC433D6;
        Thu, 11 Aug 2022 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660198801;
        bh=3UwPeUeQ7VjDnVNZ+LHhCUxVFGX5ZUyFg7qjSB+Mf2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPZw0hIwdfWFx7Nay1KSTarxP3gtJFHt0j/W+VsjS9bqO+LLKEpBAa9J5o+bO799H
         iiyKae2sAUwRT4YRJvtnQULqmxR+LBOwUE1I42tjJO+4RV0tjBDromCMjPRjWzYfc9
         9jDUIr59O/AVdBSdS0wqDJu10mUBumVF2PiSXXSY/LSbmb8St4Wvrh/InyOjh1eItF
         Q7s2KnEQYf48D3W9RLmyaIoEV9a8qqYdRjA35pMY0AwEdbHuBr6CxQLnwn5c+4OVHv
         /zD/wYk6ExOMGTXabQWOLZVH3+slWoSwMqVZ03WdjQctE9HtqzmFUNuVZMJ8elzXhp
         2hy0Ho/kvnrEQ==
Date:   Wed, 10 Aug 2022 23:19:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Message-ID: <YvSfjwCu69ivTGIZ@sol.localdomain>
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuoRuP2pxgSQ6c9E@kroah.com>
 <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 04:34:55PM +1000, Daniil Lunev wrote:
> > > +
> > > +/*
> > > + * The "capabilities" sysfs group represents the effective capabilities of the
> > > + * host-device pair, i.e. the capabilities which are enabled in the driver for
> > > + * the specific host controller, supported by the host controller and are
> > > + * supported and/or have compatible configuration on the device side.
> >
> > Why is this information not also in the Documentation/ABI/ entries as
> > well?
> >
> How would you want me to word it in there? For each entry? There
> will be more in the future, would we need to just copy it as a
> boilerplate? Bart suggested it be added in the code, do you see
> a good way to mention the same in the doc?
> Thanks,
> --Daniil

This is describing the directory, so please include it in a documentation entry
for the directory itself (/sys/bus/platform/drivers/ufshcd/*/capabilities/) just
above the documentation entries for the files in the directory.

- Eric
