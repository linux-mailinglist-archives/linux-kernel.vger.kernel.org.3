Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDEC4E7263
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356919AbiCYLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbiCYLmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:42:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95865C55A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:41:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114FB12FC;
        Fri, 25 Mar 2022 04:41:03 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180C93F73B;
        Fri, 25 Mar 2022 04:41:01 -0700 (PDT)
Date:   Fri, 25 Mar 2022 11:41:00 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        cristian.marussi@arm.com
Subject: Re: [RFC PATCH 0/2] Sensor readings fixes
Message-ID: <Yj2qTMcW9sfMyvAc@e120937-lin>
References: <20211220174155.40239-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220174155.40239-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:41:53PM +0000, Cristian Marussi wrote:
> Hi,
> 
> this was supposed to be an easy fix on how sensor readings are handled
> across different FW versions while maintaining backward compatibility,
> but the solution raised for me more questions than the issue itself...
> ...so I posted as an RFC.
> 
> In a nutshell, since SCMI FWv3.0 spec, sensors SCMI_READING_GET command
> can report axis and timestamps too, beside readings, so a brand new
> scmi_reading_get_timestamped protocol operation was exposed (used by IIO)
> while the old scmi_reading_get was kept as it was, already used by HWMON
> subsystem for other classes of sensors.
> 
> Unfortunately, also the flavour of reported values changed from unsigned
> to signed with v3.0, so if you end-up on a system running against an SCMI
> v3.0 FW platform you could end up reading a negative value and interpreting
> it as a big positive since scmi_reading_get reports only u64.
> 
> 01/02 simply takes care, when a FW >= 3.0 is detected, to return an error
> to any scmi_reading_get request if that would result in tryinh to carry
> a negative value into an u64.
> 
> So this should rectify the API exposed by SCMI sensor and make it
> consistent in general, in such a way that a user calling it won't risk to
> receive a false big-positive which was indeed a 2-complement negative from
> the perpective of the SCMI fw.
> 	
> So far so good...sort of...since, to make things more dire, the HWMON
> interface, which is the only current upstream user of scmi_reading_get
> DOES allow indeed to report to the HWMON core negative values, so it was
> just that we were silently interpreting u64 as s64 :P ...
> 
> ...as a consequence the fix above to the SCMI API will potentially break
> this undocumented behaviour of our only scmi_reading_get user.
> 
> Additionally, while looking at this, I realized that for similar reasons
> even on systems running the current SCMI stack API and an old FW <=2.0
> the current HWMON read is potentially broken, since when the FW reports
> a very big and real positive number we'll report it as a signed long to
> the HWMON core, so turning it wrongly into a negative report: for this
> reason 02/02 adds a check inside scmi-hwmon to filter out, reporting
> errors, any result reported by scmi_reading_get so big as to be considered
> a negative in 2-complement...
> 
> ...and this will probably break even more the undocumented behaviours...
> 
> Any feedback welcome !

Hi,

any feedback on this ? (...before I forgot again :D)

Thanks,
Cristian

