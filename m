Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40D4EC6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbiC3OpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiC3OpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:45:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED9505AEE0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:43:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6256B23A;
        Wed, 30 Mar 2022 07:43:30 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DF843F73B;
        Wed, 30 Mar 2022 07:43:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:43:27 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com
Subject: Re: [RFC PATCH 0/2] Sensor readings fixes
Message-ID: <YkRsj1v/PWbebDzo@e120937-lin>
References: <20211220174155.40239-1-cristian.marussi@arm.com>
 <Yj2qTMcW9sfMyvAc@e120937-lin>
 <faf91200-4790-1210-7ba5-7892c98fcb5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf91200-4790-1210-7ba5-7892c98fcb5e@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 02:38:06PM -0700, Florian Fainelli wrote:
> On 3/25/22 04:41, Cristian Marussi wrote:
> > On Mon, Dec 20, 2021 at 05:41:53PM +0000, Cristian Marussi wrote:
> > > Hi,
> > > 
> > > this was supposed to be an easy fix on how sensor readings are handled
> > > across different FW versions while maintaining backward compatibility,
> > > but the solution raised for me more questions than the issue itself...
> > > ...so I posted as an RFC.
> > > 
> > > In a nutshell, since SCMI FWv3.0 spec, sensors SCMI_READING_GET command
> > > can report axis and timestamps too, beside readings, so a brand new
> > > scmi_reading_get_timestamped protocol operation was exposed (used by IIO)
> > > while the old scmi_reading_get was kept as it was, already used by HWMON
> > > subsystem for other classes of sensors.
> > > 
> > > Unfortunately, also the flavour of reported values changed from unsigned
> > > to signed with v3.0, so if you end-up on a system running against an SCMI
> > > v3.0 FW platform you could end up reading a negative value and interpreting
> > > it as a big positive since scmi_reading_get reports only u64.
> > > 
> > > 01/02 simply takes care, when a FW >= 3.0 is detected, to return an error
> > > to any scmi_reading_get request if that would result in tryinh to carry
> > > a negative value into an u64.
> > > 
> > > So this should rectify the API exposed by SCMI sensor and make it
> > > consistent in general, in such a way that a user calling it won't risk to
> > > receive a false big-positive which was indeed a 2-complement negative from
> > > the perpective of the SCMI fw.
> > > 	
> > > So far so good...sort of...since, to make things more dire, the HWMON
> > > interface, which is the only current upstream user of scmi_reading_get
> > > DOES allow indeed to report to the HWMON core negative values, so it was
> > > just that we were silently interpreting u64 as s64 :P ...
> > > 
> > > ...as a consequence the fix above to the SCMI API will potentially break
> > > this undocumented behaviour of our only scmi_reading_get user.
> > > 
> > > Additionally, while looking at this, I realized that for similar reasons
> > > even on systems running the current SCMI stack API and an old FW <=2.0
> > > the current HWMON read is potentially broken, since when the FW reports
> > > a very big and real positive number we'll report it as a signed long to
> > > the HWMON core, so turning it wrongly into a negative report: for this
> > > reason 02/02 adds a check inside scmi-hwmon to filter out, reporting
> > > errors, any result reported by scmi_reading_get so big as to be considered
> > > a negative in 2-complement...
> > > 
> > > ...and this will probably break even more the undocumented behaviours...
> > > 
> > > Any feedback welcome !
> > 
> > Hi,
> > 
> > any feedback on this ? (...before I forgot again :D)
> 
> Sorry for the lag, I threw these into a build and the first thing that
> popped is the following warning on a 32-bit ARM build:
> 

Hi Florian,

thanks for the feedback first of all...

> In file included from ./include/linux/bits.h:6,
>                  from ./include/linux/bitops.h:6,
>                  from ./include/linux/hwmon.h:15,
>                  from drivers/hwmon/scmi-hwmon.c:9:
> drivers/hwmon/scmi-hwmon.c: In function 'scmi_hwmon_read':
> ./include/vdso/bits.h:7:26: warning: left shift count >= width of type
> [-Wshift-count-overflow]
>  #define BIT(nr)   (UL(1) << (nr))
>                           ^~
> drivers/hwmon/scmi-hwmon.c:88:14: note: in expansion of macro 'BIT'
>   if (value & BIT(63)) {
>               ^~~
> 

..and sorry that the series does not seem in good shape...

> Now, in terms of functional testing it did seems to work as intended for
> 32-bit kernels not for 64-bit kernels where I got:
> 
> # sensors
> scmi_sensors-virtual-0
> Adapter: Virtual device
> [   16.413590] hwmon hwmon0: Reported unsigned value too big.
> ERROR: Can't get value of subfeature temp1_input: I/O error
> avs_pvt_temp:         N/A
> pmic_die_temp:    +53.4 C
> 

So this is my patch apparently breaking things....which was what I wanted
to verify really :P ... the thing is that up till SCMI v2.0 (Sensor Vers
<= 0x10000) the SENSOR_READING_GET command returned a single u32
reading-value by the spec, after that, starting with SCMIv3.0, the
SENSOR_READING_GET returned also a timestamp and per-axis reading-values
BUT these readings are now signed s32 !

So I kept the old SCMI interface as it was (used by HWMON):

int (*reading_get)(const struct scmi_protocol_handle *ph, u32 sensor_id,
                           u64 *value);

and introduced a new one for timestamped/per-axis values provided by newer
FW (used by SCMI IIO driver):

int (*reading_get_timestamped)(const struct scmi_protocol_handle *ph,
                               u32 sensor_id, u8 count,
                               struct scmi_sensor_reading *readings);

(which conveys timestamps and s32 values inside the *readings)

The old interface pass back unsigned values only, in theory, BUT its only
user HWMON hanldes also negatives, so, it sort of makes sense if the FW
conveyed signed values inside an unsigned variable in the context of HWMON,
(breaking the spec) since it cannot convey negatives in any other way...

The whole point of this (broken) series was to try to see if I could sort
of sanitizing the results depending on the backend FW version detected
while maintaining backward compatibility...but the current approach of this
series is deadly broken (as you had seen :<) since makes impossible really
at the end for the FW to convey negative values as a whole...

I'll have a thought about it but I think I'll drop this series as it is...

> whereas 32-bit would return the following:
> 
> # sensors
> scmi_sensors-virtual-0
> Adapter: Virtual device
> avs_pvt_temp:      -6.7 C
> pmic_die_temp:    +52.3 C
> 
> The firmware is version 1:
> 
> [    0.044969] arm-scmi brcm_scmi@0: SCMI Protocol v1.0 'brcm-scmi:'
> Firmware version 0x1
> 
 I think this works because my patch is flaky :P ... but as said I'll drop
this as it is now.

Thanks and sorry for the noise,
Cristian

