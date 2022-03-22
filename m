Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B24E3DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiCVLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiCVLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:42:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC89F5BE68;
        Tue, 22 Mar 2022 04:40:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 842BC1596;
        Tue, 22 Mar 2022 04:40:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20FF83F66F;
        Tue, 22 Mar 2022 04:40:53 -0700 (PDT)
Date:   Tue, 22 Mar 2022 11:40:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [PATCH v2 0/2] regulator: scmi: add support for registering SCMI
 regulators by name
Message-ID: <Yjm1wpcMZsZJJCuy@bogus>
References: <cover.1647909090.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647909090.git.quic_collinsd@quicinc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:47:18PM -0700, David Collins wrote:
> Add support to register SCMI regulator subnodes based on an SCMI
> Voltage Domain name specified via the "arm,scmi-domain-name" device
> tree property.  In doing so, make the "reg" property optional with
> the constraint that at least one of "reg" or "arm,scmi-domain-name"
> must be specified.  If both are specified, then both must match the
> Voltage Domain data exposed by the SCMI platform.
>

Since the SCMI specification allows discovery of names based on the
numbering scheme, we haven't added support for the name explicitly.
However, I have heard/received couple of such feedback to provide
name based access in private so far. So good to have this discussion
in public.

> Name based SCMI regulator registration helps ensure that an SCMI
> agent doesn't need to be aware of the numbering scheme used for
> Voltage Domains by the SCMI platform.

While I understand the regulator framework has a good support for name
based approach you prefer, I see other frameworks like clock rely on
numbering scheme and I see quite a few qualcomm platforms upstream use
the number scheme for clocks. So why is that a problem with regulator ?

Another main issue I have is what if the firmware and DT end up with a
mismatch say with a firmware upgrade or a DT update ? Basically out of sync
between DT and the SCMI firmware. I see this as duplication of source of
information and is always cause for the trouble. I don't want to end up with
the quirks to deal with (totally unnecessary) issues this may create in long
run.

> It also ensures that the
> correct Voltage Domain is selected for a given physical regulator.

How is that done magically if I give wrong regulator name ? Sorry the way
it is presented sounds like adding name fixes something that numerical
ID alone will always break.

> This cannot be guaranteed with numeric Voltage Domain IDs alone.
>

If the IDs are correct like the names, it is guaranteed. I see this
ID vs name is more for some maintenance convenience because somewhere
something else needs to changes or moved away from existing way of
maintenance.

That said, if others believe, this is useful, I am happy to consider
esp. if there are more *real* reasons for doing this.

Please add clock and other subsystem maintainers who also have numbering
scheme as main mechanism in the upstream so that we get feedback from them
too.

-- 
Regards,
Sudeep
