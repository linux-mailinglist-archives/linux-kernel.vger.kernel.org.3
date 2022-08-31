Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D25A8087
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiHaOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiHaOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:46:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3276CB5E3;
        Wed, 31 Aug 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957161; x=1693493161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TG1vuMvRIFaD0zJWj5GedBI8jrdK6wo2Pj8IILYurgk=;
  b=jFIH1DBf7bNockYAWJy3u3t3NYXCTLYJpXt/4lYXUw4Chi1N6xOBqS/5
   6pRXtSqyk24il0/H0i3TgPJ+xhr/bvJJTz5YbHXmGMjhesTh+/xCaMvn7
   9Ps/pvs0sXHmIfLV87wJ10zz3WTMNhVarNXBcslsYMU9rV6ptSfEoSHsh
   r3PuYklAM5LoJ1fvp8Kq0mzcmIIeZEI7AXMnEZylmFw64wkg2x/xBJZz9
   wJ3hoVJdVlBeQ8cMvl/G/rYzJjN+ixPNxVk4v6PHw6y3mdAntYIZcnPeK
   Hg7eqEkKfyrSGxBQgRbnfr9xsCJDavy08PhhquKMHKWEXrbsbGU3z+rp+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321601435"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="321601435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="754440321"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Aug 2022 07:45:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Aug 2022 17:45:58 +0300
Date:   Wed, 31 Aug 2022 17:45:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
Message-ID: <Yw90JmdIxg/YdUYH@kuha.fi.intel.com>
References: <20220831001555.285081-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831001555.285081-1-badhri@google.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badhri,

On Tue, Aug 30, 2022 at 05:15:53PM -0700, Badhri Jagan Sridharan wrote:
> On some of the TCPC implementations, when the Type-C port is exposed
> to contaminants, such as water, TCPC stops toggling while reporting OPEN
> either by the time TCPM reads CC pin status or during CC debounce
> window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> to restart toggling, the behavior recurs causing redundant CPU wakeups
> till the USB-C port is free of contaminant.
> 
> [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> ...
> 
> To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
> can implement the check_contaminant callback which is invoked by TCPM
> to evaluate for presence of contaminant. Lower level TCPC driver can
> restart toggling through TCPM_PORT_CLEAN event when the driver detects
> that USB-C port is free of contaminant. check_contaminant callback also passes
> the disconnect_while_debounce flag which when true denotes that the CC pins
> transitioned to OPEN state during the CC debounce window.

I'm a little bit concerned about the size of the state machine. I
think this is a special case that at least in the beginning only the
Maxim port controller can support, but it's still mixed into the
"generic" state machine.

How about if we just add "run_state_machine" callback for the port
controller drivers so they can handle this kind of special cases on
their own - they can then also add custom states?

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 904c7b4ce2f0c..91c22945ba258 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4858,9 +4858,11 @@ static void run_state_machine(struct tcpm_port *port)
                tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
                break;
        default:
-               WARN(1, "Unexpected port state %d\n", port->state);
                break;
        }
+
+       if (port->tcpc->run_state_machine)
+               port->tcpc->run_state_machine(port->tcpc);
 }
 
 static void tcpm_state_machine_work(struct kthread_work *work)

thanks,

-- 
heikki
