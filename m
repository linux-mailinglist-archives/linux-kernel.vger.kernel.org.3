Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27534B762E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiBOTfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:35:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiBOTfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:35:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87876B91E9;
        Tue, 15 Feb 2022 11:35:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0B7617A5;
        Tue, 15 Feb 2022 19:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40041C340EB;
        Tue, 15 Feb 2022 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953699;
        bh=pdGYi1kiXeivN1s3yIpxJfm+hVDHt8bzmd6OOqgmGng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhBFe/n5Ms1MtXMAwyJtCKUykcvg1AkjwZ579/0jN9N6qrrMFFkKfKOGJlEZZ+EqC
         7yF6D7/I8gaT1kNBVNwpPXXdZCERQ7Vd9O4y5x7NZCnB9sO6eqTnv94KJsepGKLzFU
         8S42gcf64MPTdVP+zUYL3uXHTU59lzj2n+VN8dXRa5Tuh+7Si46BJpMLiUvXOp5Zlv
         B4l1+JK5l3+YgHp/s7T2zETOafdIPsQCv5jeI+5WFMVzfwwWHqwdDrFo7rQ+XBR2V6
         FRUc0BtMNrMfOrvoKWliAsV8K+ipM5iRd+Bdxz/UwZ98sK1w1QWsdW0sOphHcOYiu/
         VhtF6kjqnBZNA==
Received: by pali.im (Postfix)
        id AD11EF13; Tue, 15 Feb 2022 20:34:56 +0100 (CET)
Date:   Tue, 15 Feb 2022 20:34:56 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] hwmon: (dell-smm) Add SMM interface documentation
Message-ID: <20220215193456.ye7odehxa3ijpqtk@pali>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-7-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191113.16640-7-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2022 20:11:12 Armin Wolf wrote:
> Document the SMM interface as requested by Pali Rohar.
> Since Dell does not offer any offical documentation
> regarding the SMM interface, the necessary information
> was extracted from the dell_smm_hwmon driver and other
> sources.
> 
> Suggested-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Perfect!

Reviewed-by: Pali Rohár <pali@kernel.org>

I have info about some more commands but I'm not sure if they are
implement on new machines:

0x00a6  get SMBIOS version
0x22a3  get charger info (1 arg)
0x24a3  get adaptor info status (1 arg oder 0x03)
0x32a3  restore normal Fn key mode (no args)
0x33a3  put the Fn key in "raw" mode (sends the scancode e009 instead of activating the Fn- functions) (no args)
0x36a3  get hotkey scancode list (args see diags; returns number of hotkeys)
0x40a3  get docking state (no args)

> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 180 +++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index cfaee682a245..12bba5fd1447 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -173,3 +173,183 @@ obtain the same information and to control the fan status. The ioctl
>  interface can be accessed from C programs or from shell using the
>  i8kctl utility. See the source file of ``i8kutils`` for more
>  information on how to use the ioctl interface.
> +
> +SMM Interface
> +-------------
> +
> +.. warning:: The SMM interface was reverse-engineered by trial-and-error
> +             since Dell did not provide any Documentation,
> +             please keep that in mind.
> +
> +The driver uses the SMM interface to send commands to the system BIOS.
> +This interface is normally used by Dell's 32-bit diagnostic program or
> +on newer notebook models by the buildin BIOS diagnostics.
> +The SMM is triggered by writing to the special ioports ``0xb2`` and ``0x84``,
> +and may cause short hangs when the BIOS code is taking too long to
> +execute.
> +
> +The SMM handler inside the system BIOS looks at the contents of the
> +``eax``, ``ebx``, ``ecx``, ``edx``, ``esi`` and ``edi`` registers.
> +Each register has a special purpose:
> +
> +=============== ==================================
> +Register        Purpose
> +=============== ==================================
> +eax             Holds the command code before SMM,
> +                holds the first result after SMM.
> +ebx             Holds the arguments.
> +ecx             Unknown, set to 0.
> +edx             Holds the second result after SMM.
> +esi             Unknown, set to 0.
> +edi             Unknown, set to 0.
> +=============== ==================================
> +
> +The SMM handler can signal a failure by either:
> +
> +- setting the lower sixteen bits of ``eax`` to ``0xffff``
> +- not modifying ``eax`` at all
> +- setting the carry flag
> +
> +SMM command codes
> +-----------------
> +
> +=============== ======================= ================================================
> +Command Code    Command Name            Description
> +=============== ======================= ================================================
> +``0x0025``      Get Fn key status       Returns the Fn key pressed after SMM:
> +
> +                                        - 9th bit in ``eax`` indicates Volume up
> +                                        - 10th bit in ``eax`` indicates Volume down
> +                                        - both bits indicate Volume mute
> +
> +``0xa069``      Get power status        Returns current power status after SMM:
> +
> +                                        - 1st bit in ``eax`` indicates Battery connected
> +                                        - 3th bit in ``eax`` indicates AC connected
> +
> +``0x00a3``      Get fan state           Returns current fan state after SMM:
> +
> +                                        - 1st byte in ``eax`` holds the current
> +                                          fan state (0 - 2 or 3)
> +
> +``0x01a3``      Set fan state           Sets the fan speed:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 2nd byte in ``ebx`` holds the desired
> +                                          fan state (0 - 2 or 3)
> +
> +``0x02a3``      Get fan speed           Returns the current fan speed in RPM:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 1st word in ``eax`` holds the current
> +                                          fan speed in RPM (after SMM)
> +
> +``0x03a3``      Get fan type            Returns the fan type:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 1st byte in ``eax`` holds the
> +                                          fan type (after SMM):
> +
> +                                          - 5th bit indicates docking fan
> +                                          - 1 indicates Processor fan
> +                                          - 2 indicates Motherboard fan
> +                                          - 3 indicates Video fan
> +                                          - 4 indicates Power supply fan
> +                                          - 5 indicates Chipset fan
> +                                          - 6 indicates other fan type
> +
> +``0x04a3``      Get nominal fan speed   Returns the nominal RPM in each fan state:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 2nd byte in ``ebx`` holds the fan state
> +                                          in question (0 - 2 or 3)
> +                                        - 1st word in ``eax`` holds the nominal
> +                                          fan speed in RPM (after SMM)
> +
> +``0x05a3``      Get fan speed tolerance Returns the speed tolerance for each fan state:
> +
> +                                        - 1st byte in ``ebx`` holds the fan number
> +                                        - 2nd byte in ``ebx`` holds the fan state
> +                                          in question (0 - 2 or 3)
> +                                        - 1st byte in ``eax`` returns the speed
> +                                          tolerance
> +
> +``0x10a3``      Get sensor temperature  Returns the measured temperature:
> +
> +                                        - 1st byte in ``ebx`` holds the sensor number
> +                                        - 1st byte in ``eax`` holds the measured
> +                                          temperature (after SMM)
> +
> +``0x11a3``      Get sensor type         Returns the sensor type:
> +
> +                                        - 1st byte in ``ebx`` holds the sensor number
> +                                        - 1st byte in ``eax`` holds the
> +                                          temperature type (after SMM):
> +
> +                                          - 1 indicates CPU sensor
> +                                          - 2 indicates GPU sensor
> +                                          - 3 indicates SODIMM sensor
> +                                          - 4 indicates other sensor type
> +                                          - 5 indicates Ambient sensor
> +                                          - 6 indicates other sensor type
> +
> +``0xfea3``      Get SMM signature       Returns Dell signature if interface
> +                                        is supported (after SMM):
> +
> +                                        - ``eax`` holds 1145651527
> +                                          (0x44494147 or "DIAG")
> +                                        - ``edx`` holds 1145392204
> +                                          (0x44454c4c or "DELL")
> +
> +``0xffa3``      Get SMM signature       Same as ``0xfea3``, check both.
> +=============== ======================= ================================================
> +
> +There are additional commands for enabling (``0x31a3`` or ``0x35a3``) and
> +disabling (``0x30a3`` or ``0x34a3``) automatic fan speed control.
> +The commands are however causing severe sideeffects on many machines, so
> +they are not used by default.
> +
> +On several machines (Inspiron 3505, Precision 490, Vostro 1720, ...), the
> +fans supports a 4th "magic" state, which signals the BIOS that automatic
> +fan control should be enabled for a specific fan.
> +However there are also some machines who do support a 4th regular fan state too,
> +but in case of the "magic" state, the nominal RPM reported for this state is a
> +placeholder value, which however is not always detectable.
> +
> +Firmware Bugs
> +-------------
> +
> +The SMM calls can behave erratic on some machines:
> +
> +======================================================= =================
> +Firmware Bug                                            Affected Machines
> +======================================================= =================
> +Reading of fan states return spurious errors.           Precision 490
> +
> +Reading of fan types causes erratic fan behaviour.      Studio XPS 8000
> +
> +                                                        Studio XPS 8100
> +
> +                                                        Inspiron 580
> +
> +Fan-related SMM calls take too long (about 500ms).      Inspiron 7720
> +
> +                                                        Vostro 3360
> +
> +                                                        XPS 13 9333
> +
> +                                                        XPS 15 L502X
> +======================================================= =================
> +
> +In case you experience similar issues on your Dell machine, please
> +submit a bugreport on bugzilla to we can apply workarounds.
> +
> +Limitations
> +-----------
> +
> +The SMM calls can take too long to execute on some machines, causing
> +short hangs and/or audio glitches.
> +Also the fan state needs to be restored after suspend, as well as
> +the automatic mode settings.
> +When reading a temperature sensor, values above 127 degrees indicate
> +a BIOS read error or a deactivated sensor.
> --
> 2.30.2
> 
