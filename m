Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0834D8F21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbiCNWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiCNWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:00:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6503434649
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:58:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nTsiF-0002d1-5R; Mon, 14 Mar 2022 22:58:47 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-6399-440a-c2a2-bdf7.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6399:440a:c2a2:bdf7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A19C74B3FD;
        Mon, 14 Mar 2022 21:58:43 +0000 (UTC)
Date:   Mon, 14 Mar 2022 22:58:43 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220314215843.xxf6rdxxfwb255s4@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ameodlqutgf56yks"
Content-Disposition: inline
In-Reply-To: <20220307214303.1822590-1-max@enpas.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ameodlqutgf56yks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.03.2022 22:43:03, Max Staudt wrote:
> This is the elmcan driver. It does a surprisingly good job at turning
> ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
> homebrew projects.
>=20
> Please see the included documentation for details and limitations:
> Documentation/networking/device_drivers/can/elmcan.rst
>=20
> CC TTY maintainers for their opinion as this patch adds a new ldisc,
> taking the very last ldisc number available (29) without increasing
> NR_LDISCS (beyond the current 30).
>=20
> Cc: linux-can <linux-can@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
> Changes in v3:
>  - Now depends on c2faf737abfb for new ldisc number 30:
>      https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commi=
t/?h=3Dtty-next&id=3Dc2faf737abfb10f88f2d2612d573e9edc3c42c37
>  - Eliminated hardcoded string lengths (GCC will work its magic).
>  - Emit generic error frames if an error message couldn't be parsed.
>  - Silence driver startup and init (but still announce ldattach).
>  - Cleaned up comments, strings, readme.
>  - Removed sole module option "accept_flaky_uart".
>    I likely had EMI in earlier testing, which is gone now.
>    This means we can stay strict, unless anyone objects.
>=20
> Changes in v2:
>  - Moved to SocketCAN's rx-offload wrapper for NAPI, thus avoiding
>    packets being reordered.
>  - Updated TTY ldisc code for Linux v5.17-rc3. A lot of cleanup has
>    happened there lately.
>  - netif_stop_queue() is called earlier in _netdev_close().
>  - Minor cleanup: More helpful strings and return values.
> ---
>  .../networking/device_drivers/can/elmcan.rst  |  325 +++++
>  .../networking/device_drivers/can/index.rst   |    1 +
>  MAINTAINERS                                   |    7 +
>  drivers/net/can/Kconfig                       |   17 +
>  drivers/net/can/Makefile                      |    1 +
>  drivers/net/can/elmcan.c                      | 1250 +++++++++++++++++
>  include/uapi/linux/tty.h                      |    3 +-
>  7 files changed, 1603 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/networking/device_drivers/can/elmcan.rst
>  create mode 100644 drivers/net/can/elmcan.c
>=20
> diff --git a/Documentation/networking/device_drivers/can/elmcan.rst b/Doc=
umentation/networking/device_drivers/can/elmcan.rst
> new file mode 100644
> index 000000000000..7656d62dd58e
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/can/elmcan.rst
> @@ -0,0 +1,325 @@
> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +
> +ELM327 driver for Linux SocketCAN
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Authors
> +--------
> +
> +Max Staudt <max@enpas.org>
> +
> +
> +
> +Motivation
> +-----------
> +
> +This driver aims to lower the initial cost for hackers interested in
> +working with CAN buses.
> +
> +CAN adapters are expensive, few, and far between.
> +ELM327 interfaces are cheap and plentiful.
> +Let's use ELM327s as CAN adapters.
> +
> +
> +
> +Introduction
> +-------------
> +
> +This driver is an effort to turn abundant ELM327 based OBD interfaces
> +into full fledged (as far as possible) CAN interfaces.
> +
> +Since the ELM327 was never meant to be a stand alone CAN controller,
> +the driver has to switch between its modes as quickly as possible in
> +order to fake full-duplex operation.
> +
> +As such, elmcan is a best effort driver. However, this is more than
> +enough to implement simple request-response protocols (such as OBD II),
> +and to monitor broadcast messages on a bus (such as in a vehicle).
> +
> +Most ELM327s come as nondescript serial devices, attached via USB or
> +Bluetooth. The driver cannot recognize them by itself, and as such it
> +is up to the user to attach it in form of a TTY line discipline
> +(similar to PPP, SLIP, slcan, ...).
> +
> +This driver is meant for ELM327 versions 1.4b and up, see below for
> +known limitations in older controllers and clones.
> +
> +
> +
> +Data sheet
> +-----------
> +
> +The official data sheets can be found at ELM electronics' home page:
> +
> +  https://www.elmelectronics.com/
> +
> +
> +
> +How to check the controller version
> +------------------------------------
> +
> +Use a terminal program to attach to the controller.
> +The default settings are 38400 baud/s, 8 data bits, no parity, 1 stopbit.
> +
> +After issuing the "``AT WS``" command, the controller will respond with
> +its version::
> +
> +    >AT WS
> +
> +
> +    ELM327 v1.4b
> +
> +    >
> +
> +Note that clones may claim to be any version they like.
> +It is not indicative of their actual feature set.
> +
> +
> +
> +How to attach the line discipline
> +----------------------------------
> +
> +Every ELM327 chip is factory programmed to operate at a serial setting
> +of 38400 baud/s, 8 data bits, no parity, 1 stopbit.
> +
> +The line discipline can be attached on a command prompt as follows::
> +
> +    sudo ldattach \
> +           --debug \
> +           --speed 38400 \
> +           --eightbits \
> +           --noparity \
> +           --onestopbit \
> +           --iflag -ICRNL,INLCR,-IXOFF \
> +           29 \
> +           /dev/ttyUSB0
> +
> +To change the ELM327's serial settings, please refer to its data
> +sheet. This needs to be done before attaching the line discipline.
> +
> +Once the ldisc is attached, the CAN interface starts out unconfigured.
> +Set the speed before starting it:
> +
> +    # The interface needs to be down to change parameters
> +    sudo ip link set can0 down
> +    sudo ip link set can0 type can bitrate 500000
> +    sudo ip link set can0 up
> +
> +500000 bit/s is a common rate for OBD-II diagnostics.
> +If you're connecting straight to a car's OBD port, this is the speed
> +that most cars (but not all!) expect.
> +
> +After this, you can set out as usual with candump, cansniffer, etc.
> +
> +
> +
> +Known limitations of the controller
> +------------------------------------
> +
> +- Clone devices ("v1.5" and others)
> +
> +  Sending RTR frames is not supported and will be dropped silently.
> +
> +  Receiving RTR with DLC 8 will appear to be a regular frame with
> +  the last received frame's DLC and payload.
> +
> +  "``AT CSM``" not supported, thus no ACK-ing frames while listening:
> +  "``AT MA``" will always be silent. However, immediately after
> +  sending a frame, the ELM327 will be in "receive reply" mode, in
> +  which it *does* ACK any received frames. Once the bus goes silent
> +  or an error occurs (such as BUFFER FULL), the ELM327 will end reply
> +  reception mode on its own and elmcan will fall back to "``AT MA``"
> +  in order to keep monitoring the bus.
> +
> +
> +- All versions
> +
> +  No full duplex operation is supported. The driver will switch
> +  between input/output mode as quickly as possible.
> +
> +  The length of outgoing RTR frames cannot be set. In fact, some
> +  clones (tested with one identifying as "``v1.5``") are unable to
> +  send RTR frames at all.
> +
> +  We don't have a way to get real-time notifications on CAN errors.
> +  While there is a command (``AT CS``) to retrieve some basic stats,
> +  we don't poll it as it would force us to interrupt reception mode.
> +
> +
> +- Versions prior to 1.4b
> +
> +  These versions do not send CAN ACKs when in monitoring mode (AT MA).
> +  However, they do send ACKs while waiting for a reply immediately
> +  after sending a frame. The driver maximizes this time to make the
> +  controller as useful as possible.
> +
> +  Starting with version 1.4b, the ELM327 supports the "``AT CSM``"
> +  command, and the "listen-only" CAN option will take effect.
> +
> +
> +- Versions prior to 1.4
> +
> +  These chips do not support the "``AT PB``" command, and thus cannot
> +  change bitrate or SFF/EFF mode on-the-fly. This will have to be
> +  programmed by the user before attaching the line discipline. See the
> +  data sheet for details.
> +
> +
> +- Versions prior to 1.3
> +
> +  These chips cannot be used at all with elmcan. They do not support
> +  the "``AT D1``" command, which is necessary to avoid parsing conflicts
> +  on incoming data, as well as distinction of RTR frame lengths.
> +
> +  Specifically, this allows for easy distinction of SFF and EFF
> +  frames, and to check whether frames are complete. While it is possible
> +  to deduce the type and length from the length of the line the ELM327
> +  sends us, this method fails when the ELM327's UART output buffer
> +  overruns. It may abort sending in the middle of the line, which will
> +  then be mistaken for something else.
> +
> +
> +
> +Known limitations of the driver
> +--------------------------------
> +
> +- No 8/7 timing.
> +
> +  ELM327 can only set CAN bitrates that are of the form 500000/n, where
> +  n is an integer divisor.
> +  However there is an exception: With a separate flag, it may set the
> +  speed to be 8/7 of the speed indicated by the divisor.
> +  This mode is not currently implemented.
> +
> +- No evaluation of command responses.
> +
> +  The ELM327 will reply with OK when a command is understood, and with ?
> +  when it is not. The driver does not currently check this, and simply
> +  assumes that the chip understands every command.
> +  The driver is built such that functionality degrades gracefully
> +  nevertheless. See the section on known limitations of the controller.
> +
> +- No use of hardware CAN ID filtering
> +
> +  An ELM327's UART sending buffer will easily overflow on heavy CAN bus
> +  load, resulting in the "``BUFFER FULL``" message. Using the hardware
> +  filters available through "``AT CF xxx``" and "``AT CM xxx``" would be
> +  helpful here, however SocketCAN does not currently provide a facility
> +  to make use of such hardware features.
> +
> +
> +
> +Communication example
> +----------------------
> +
> +This is a short and incomplete introduction on how to talk to an ELM327.
> +
> +
> +The ELM327 has two modes:
> +
> +- Command mode
> +- Reception mode
> +
> +In command mode, it expects one command per line, terminated by CR.
> +By default, the prompt is a "``>``", after which a command can be
> +entered::
> +
> +    >ATE1
> +    OK
> +    >
> +
> +The init script in the driver switches off several configuration options
> +that are only meaningful in the original OBD scenario the chip is meant
> +for, and are actually a hindrance for elmcan.
> +
> +
> +When a command is not recognized, such as by an older version of the
> +ELM327, a question mark is printed as a response instead of OK::
> +
> +    >ATUNKNOWN
> +    ?
> +    >
> +
> +At present, elmcan does not evaluate this response and silently assumes
> +that all commands are recognized. It is structured such that it will
> +degrade gracefully when a command is unknown. See the sections above on
> +known limitations for details.
> +
> +
> +When a CAN frame is to be sent, the target address is configured, after
> +which the frame is sent as a command that consists of the data's hex
> +dump::
> +
> +    >ATSH123
> +    OK
> +    >DEADBEEF12345678
> +    OK
> +    >
> +
> +The above interaction sends the frame "``DE AD BE EF 12 34 56 78``" with
> +the 11 bit CAN ID ``0x123``.
> +For this to function, the controller must be configured for 11 bit CAN
> +ID sending mode (using "``AT PB``", see code or datasheet).
> +
> +
> +Once a frame has been sent and wait-for-reply mode is on (``ATR1``,
> +configured on ``listen-only=3Doff``), or when the reply timeout expires =
and
> +the driver sets the controller into monitoring mode (``ATMA``), the ELM3=
27
> +will send one line for each received CAN frame, consisting of CAN ID,
> +DLC, and data::
> +
> +    123 8 DEADBEEF12345678
> +
> +For 29 bit CAN frames, the address format is slightly different, which
> +elmcan uses to tell the two apart::
> +
> +    12 34 56 78 8 DEADBEEF12345678
> +
> +The ELM327 will receive both 11 and 29 bit frames - the current CAN
> +config (``ATPB``) does not matter.
> +
> +
> +If the ELM327's internal UART sending buffer runs full, it will abort
> +the monitoring mode, print "BUFFER FULL" and drop back into command
> +mode. Note that in this case, unlike with other error messages, the
> +error message may appear on the same line as the last (usually
> +incomplete) data frame::
> +
> +    12 34 56 78 8 DEADBEEF123 BUFFER FULL
> +
> +
> +
> +Rationale behind the chosen configuration
> +------------------------------------------
> +
> +``AT E1``
> +  Echo on
> +
> +  We need this to be able to get a prompt reliably.
> +
> +``AT S1``
> +  Spaces on
> +
> +  We need this to distinguish 11/29 bit CAN addresses received.
> +
> +  Note:
> +  We can usually do this using the line length (odd/even),
> +  but this fails if the line is not transmitted fully to
> +  the host (BUFFER FULL).
> +
> +``AT D1``
> +  DLC on
> +
> +  We need this to tell the "length" of RTR frames.
> +
> +
> +
> +A note on CAN bus termination
> +------------------------------
> +
> +Your adapter may have resistors soldered in which are meant to terminate
> +the bus. This is correct when it is plugged into a OBD-II socket, but
> +not helpful when trying to tap into the middle of an existing CAN bus.
> +
> +If communications don't work with the adapter connected, check for the
> +termination resistors on its PCB and try removing them.
> diff --git a/Documentation/networking/device_drivers/can/index.rst b/Docu=
mentation/networking/device_drivers/can/index.rst
> index 58b6e0ad3030..e3f2be735aef 100644
> --- a/Documentation/networking/device_drivers/can/index.rst
> +++ b/Documentation/networking/device_drivers/can/index.rst
> @@ -10,6 +10,7 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
> =20
> +   elmcan
>     freescale/flexcan
> =20
>  .. only::  subproject and html
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e461db9cd91..7bb266dbffd1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7064,6 +7064,13 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/ibm/ehea/
> =20
> +ELM327 CAN NETWORK DRIVER
> +M:	Max Staudt <max@enpas.org>
> +L:	linux-can@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/networking/device_drivers/can/elmcan.rst
> +F:	drivers/net/can/elmcan.c
> +
>  EM28XX VIDEO4LINUX DRIVER
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index fff259247d52..226bd00fc048 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -180,6 +180,23 @@ source "drivers/net/can/softing/Kconfig"
>  source "drivers/net/can/spi/Kconfig"
>  source "drivers/net/can/usb/Kconfig"
> =20
> +config CAN_ELMCAN
> +	tristate "Serial / USB serial ELM327 based OBD-II Interfaces (elmcan)"
> +	depends on TTY
> +	help
> +	  CAN driver for several 'low cost' OBD-II interfaces based on the
> +	  ELM327 OBD-II interpreter chip.
> +
> +	  This is a best effort driver - the ELM327 interface was never
> +	  designed to be used as a standalone CAN interface. However, it can
> +	  still be used for simple request-response protocols (such as OBD II),
> +	  and to monitor broadcast messages on a bus (such as in a vehicle).
> +
> +	  Please refer to the documentation for information on how to use it:
> +	  Documentation/networking/device_drivers/can/elmcan.rst
> +
> +	  If this driver is built as a module, it will be called elmcan.
> +
>  endif
> =20
>  config CAN_DEBUG_DEVICES
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 1e660afcb61b..c25a0f8a397b 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_CAN_VCAN)		+=3D vcan.o
>  obj-$(CONFIG_CAN_VXCAN)		+=3D vxcan.o
>  obj-$(CONFIG_CAN_SLCAN)		+=3D slcan.o
> +obj-$(CONFIG_CAN_ELMCAN)	+=3D elmcan.o

Please keep that list sorted alphabetically. Please move the "config
CAN_ELMCAN" accordingly.

> =20
>  obj-y				+=3D dev/
>  obj-y				+=3D rcar/
> diff --git a/drivers/net/can/elmcan.c b/drivers/net/can/elmcan.c
> new file mode 100644
> index 000000000000..2d7ebc40a492
> --- /dev/null
> +++ b/drivers/net/can/elmcan.c
> @@ -0,0 +1,1250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* ELM327 based CAN interface driver (tty line discipline)
> + *
> + * This driver started as a derivative of linux/drivers/net/can/slcan.c
> + * and my thanks go to the original authors for their inspiration, even
> + * after almost none of their code is left.

You might want to list the (c) of the authors of the slcan.c

> + */
> +
> +#define pr_fmt(fmt) "[elmcan] " fmt

Just "elmcan"

> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/ctype.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/if_ether.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/tty.h>
> +#include <linux/tty_ldisc.h>
> +#include <linux/workqueue.h>
> +
> +#include <uapi/linux/tty.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/can/led.h>
> +#include <linux/can/rx-offload.h>
> +
> +MODULE_ALIAS_LDISC(N_ELMCAN);
> +MODULE_DESCRIPTION("ELM327 based CAN interface");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Max Staudt <max@enpas.org>");

Please move the MODULE_* to the end of the file

> +
> +#define ELM327_NAPI_WEIGHT 4
> +
> +#define ELM327_SIZE_RXBUF 256
> +#define ELM327_SIZE_TXBUF 32
> +
> +#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
> +#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
> +#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
> +#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000
> +
> +#define ELM327_DUMMY_CHAR 'y'
> +#define ELM327_DUMMY_STRING "y"
> +#define ELM327_READY_CHAR '>'
> +
> +/* Bits in elm->cmds_todo */
> +enum ELM_TODO {
        ^^^^^^^^
small caps please, and Vincent alreadt commented on the name.

> +	TODO_CAN_DATA =3D 0,
> +	TODO_CANID_11BIT,
> +	TODO_CANID_29BIT_LOW,
> +	TODO_CANID_29BIT_HIGH,
> +	TODO_CAN_CONFIG_PART2,
> +	TODO_CAN_CONFIG,
> +	TODO_RESPONSES,
> +	TODO_SILENT_MONITOR,
> +	TODO_INIT
> +};
> +
> +struct elmcan {
> +	/* This must be the first member when using alloc_candev() */
> +	struct can_priv can;

Please use a consistent indention scheme, e.g. one space only.
> +
> +	struct can_rx_offload offload;
> +
> +	/* TTY and netdev devices that we're bridging */
> +	struct tty_struct	*tty;
> +	struct net_device	*dev;
> +
> +	/* Per-channel lock */
> +	spinlock_t		lock;
> +
> +	/* Keep track of how many things are using this struct.
> +	 * Once it reaches 0, we are in the process of cleaning up,
> +	 * and new operations will be cancelled immediately.
> +	 * Use atomic_t rather than refcount_t because we deliberately
> +	 * decrement to 0, and refcount_dec() spills a WARN_ONCE in
> +	 * that case.
> +	 */
> +	atomic_t		refcount;
> +
> +	/* Stop the channel on hardware failure.
> +	 * Once this is true, nothing will be sent to the TTY.
> +	 */
> +	bool			hw_failure;
> +
> +	/* TTY TX helpers */
> +	struct work_struct	tx_work;	/* Flushes TTY TX buffer   */
> +	unsigned char		*txbuf;
> +	unsigned char		*txhead;	/* Pointer to next TX byte */
> +	int			txleft;		/* Bytes left to TX */
> +
> +	/* TTY RX helpers */
> +	unsigned char rxbuf[ELM327_SIZE_RXBUF];
> +	int rxfill;
> +
> +	/* State machine */
> +	enum {
> +		ELM_NOTINIT =3D 0,
> +		ELM_GETDUMMYCHAR,
> +		ELM_GETPROMPT,
> +		ELM_RECEIVING,

ELM_STATE_

> +	} state;
> +
> +	int drop_next_line;

bool?

> +
> +	/* The CAN frame and config the ELM327 is sending/using,
> +	 * or will send/use after finishing all cmds_todo
> +	 */
> +	struct can_frame can_frame;
> +	unsigned short can_config;

u16?

> +	unsigned long can_bitrate;

unused?

> +	unsigned char can_bitrate_divisor;

u8?

> +	int silent_monitoring;

unused?

> +
> +	/* Things we have yet to send */
> +	char **next_init_cmd;
> +	unsigned long cmds_todo;
> +};
> +
> +/* A lock for all tty->disc_data handled by this ldisc.
> + * This is to prevent a case where tty->disc_data is set to NULL,
> + * yet someone is still trying to dereference it.
> + * Without this, we cannot do a clean shutdown.
> + */
> +static DEFINE_SPINLOCK(elmcan_discdata_lock);
> +
> +static inline void elm327_hw_failure(struct elmcan *elm);
> +
> +/* Assumes elm->lock taken. */

Remove comment and add...

> +static void elm327_send(struct elmcan *elm, const void *buf, size_t len)
> +{
> +	int actual;
> +

lockdep_assert_held(elm->lock);

> +	if (elm->hw_failure)
> +		return;
> +
> +	memcpy(elm->txbuf, buf, len);
> +
> +	/* Order of next two lines is *very* important.
> +	 * When we are sending a little amount of data,
> +	 * the transfer may be completed inside the ops->write()
> +	 * routine, because it's running with interrupts enabled.
> +	 * In this case we *never* got WRITE_WAKEUP event,
> +	 * if we did not request it before write operation.
> +	 *       14 Oct 1994  Dmitry Gorodchanin.
> +	 */
> +	set_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
> +	actual =3D elm->tty->ops->write(elm->tty, elm->txbuf, len);
> +	if (actual < 0) {
> +		netdev_err(elm->dev,
> +			   "Failed to write to tty %s.\n",
> +			   elm->tty->name);
> +		elm327_hw_failure(elm);
> +		return;
> +	}
> +
> +	elm->txleft =3D len - actual;
> +	elm->txhead =3D elm->txbuf + actual;
> +}
> +
> +/* Take the ELM327 out of almost any state and back into command mode.
> + * We send ELM327_DUMMY_CHAR which will either abort any running
> + * operation, or be echoed back to us in case we're already in command
> + * mode.
> + *
> + * Assumes elm->lock taken.
> + */
> +static void elm327_kick_into_cmd_mode(struct elmcan *elm)
> +{
> +	if (elm->state !=3D ELM_GETDUMMYCHAR && elm->state !=3D ELM_GETPROMPT) {
> +		elm327_send(elm, ELM327_DUMMY_STRING, 1);
> +
> +		elm->state =3D ELM_GETDUMMYCHAR;
> +	}
> +}
> +
> +/* Schedule a CAN frame and necessary config changes to be sent to the T=
TY.
> + *
> + * Assumes elm->lock taken.
> + */
> +static void elm327_send_frame(struct elmcan *elm, struct can_frame *fram=
e)
> +{
> +	/* Schedule any necessary changes in ELM327's CAN configuration */
> +	if (elm->can_frame.can_id !=3D frame->can_id) {
> +		/* Set the new CAN ID for transmission. */
> +		if ((frame->can_id & CAN_EFF_FLAG)

Please move operator to the end of the line.

> +		    ^ (elm->can_frame.can_id & CAN_EFF_FLAG)) {
> +			elm->can_config =3D (frame->can_id & CAN_EFF_FLAG
> +						? 0
> +						: ELM327_CAN_CONFIG_SEND_SFF)
> +					| ELM327_CAN_CONFIG_VARIABLE_DLC
> +					| ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF
> +					| elm->can_bitrate_divisor;
> +
> +			set_bit(TODO_CAN_CONFIG, &elm->cmds_todo);
> +		}
> +
> +		if (frame->can_id & CAN_EFF_FLAG) {
> +			clear_bit(TODO_CANID_11BIT, &elm->cmds_todo);
> +			set_bit(TODO_CANID_29BIT_LOW, &elm->cmds_todo);
> +			set_bit(TODO_CANID_29BIT_HIGH, &elm->cmds_todo);
> +		} else {
> +			set_bit(TODO_CANID_11BIT, &elm->cmds_todo);
> +			clear_bit(TODO_CANID_29BIT_LOW, &elm->cmds_todo);
> +			clear_bit(TODO_CANID_29BIT_HIGH, &elm->cmds_todo);
> +		}
> +	}
> +
> +	/* Schedule the CAN frame itself. */
> +	elm->can_frame =3D *frame;
> +	set_bit(TODO_CAN_DATA, &elm->cmds_todo);
> +
> +	elm327_kick_into_cmd_mode(elm);
> +}
> +
> +/* ELM327 initialization sequence.
> + *
> + * Assumes elm->lock taken.
> + */
> +static char *elm327_init_script[] =3D {
> +	"AT WS\r",        /* v1.0: Warm Start */
> +	"AT PP FF OFF\r", /* v1.0: All Programmable Parameters Off */
> +	"AT M0\r",        /* v1.0: Memory Off */
> +	"AT AL\r",        /* v1.0: Allow Long messages */
> +	"AT BI\r",        /* v1.0: Bypass Initialization */
> +	"AT CAF0\r",      /* v1.0: CAN Auto Formatting Off */
> +	"AT CFC0\r",      /* v1.0: CAN Flow Control Off */
> +	"AT CF 000\r",    /* v1.0: Reset CAN ID Filter */
> +	"AT CM 000\r",    /* v1.0: Reset CAN ID Mask */
> +	"AT E1\r",        /* v1.0: Echo On */
> +	"AT H1\r",        /* v1.0: Headers On */
> +	"AT L0\r",        /* v1.0: Linefeeds Off */
> +	"AT SH 7DF\r",    /* v1.0: Set CAN sending ID to 0x7df */
> +	"AT ST FF\r",     /* v1.0: Set maximum Timeout for response after TX */
> +	"AT AT0\r",       /* v1.2: Adaptive Timing Off */
> +	"AT D1\r",        /* v1.3: Print DLC On */
> +	"AT S1\r",        /* v1.3: Spaces On */
> +	"AT TP B\r",      /* v1.0: Try Protocol B */
> +	NULL
> +};
> +
> +static void elm327_init(struct elmcan *elm)
> +{
> +	elm->state =3D ELM_NOTINIT;
> +	elm->can_frame.can_id =3D 0x7df;
> +	elm->rxfill =3D 0;
> +	elm->drop_next_line =3D 0;
> +
> +	/* We can only set the bitrate as a fraction of 500000.
> +	 * The bit timing constants in elmcan_bittiming_const will
> +	 * limit the user to the right values.
> +	 */
> +	elm->can_bitrate_divisor =3D 500000 / elm->can.bittiming.bitrate;
> +	elm->can_config =3D ELM327_CAN_CONFIG_SEND_SFF
> +			| ELM327_CAN_CONFIG_VARIABLE_DLC
> +			| ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF
> +			| elm->can_bitrate_divisor;
> +
> +	/* Configure ELM327 and then start monitoring */
> +	elm->next_init_cmd =3D &elm327_init_script[0];
> +	set_bit(TODO_INIT, &elm->cmds_todo);
> +	set_bit(TODO_SILENT_MONITOR, &elm->cmds_todo);
> +	set_bit(TODO_RESPONSES, &elm->cmds_todo);
> +	set_bit(TODO_CAN_CONFIG, &elm->cmds_todo);
> +
> +	elm327_kick_into_cmd_mode(elm);
> +}
> +
> +/* Assumes elm->lock taken. */
> +static void elm327_feed_frame_to_netdev(struct elmcan *elm,
> +					const struct can_frame *frame)
> +{
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	if (!netif_running(elm->dev))
> +		return;
> +
> +	skb =3D alloc_can_skb(elm->dev, &cf);
> +
> +	if (!skb)
> +		return;
> +
> +	memcpy(cf, frame, sizeof(struct can_frame));
> +
> +	/* Queue for NAPI pickup.
> +	 * rx-offload will update stats and LEDs for us.
> +	 */
> +	if (can_rx_offload_queue_tail(&elm->offload, skb))
> +		elm->dev->stats.rx_fifo_errors++;
> +
> +	/* Wake NAPI */
> +	can_rx_offload_irq_finish(&elm->offload);
> +}
> +
> +/* Called when we're out of ideas and just want it all to end.
> + * Assumes elm->lock taken.
> + */
> +static inline void elm327_hw_failure(struct elmcan *elm)
> +{
> +	struct can_frame frame;
> +
> +	memset(&frame, 0, sizeof(frame));
> +	frame.can_id =3D CAN_ERR_FLAG;
> +	frame.can_dlc =3D CAN_ERR_DLC;
> +	frame.data[5] =3D 'R';
> +	frame.data[6] =3D 'I';
> +	frame.data[7] =3D 'P';
> +	elm327_feed_frame_to_netdev(elm, &frame);
> +
> +	netdev_err(elm->dev, "ELM327 misbehaved. Blocking further communication=
=2E\n");
> +
> +	elm->hw_failure =3D true;
> +	can_bus_off(elm->dev);
> +}
> +
> +/* Compare a buffer to a fixed string */
> +static inline int _memstrcmp(const u8 *mem, const char *str)
> +{
> +	return memcmp(mem, str, strlen(str));
> +}
> +
> +/* Compare buffer to string length, then compare buffer to fixed string.
> + * This ensures two things:
> + *  - It flags cases where the fixed string is only the start of the
> + *    buffer, rather than exactly all of it.
> + *  - It avoids byte comparisons in case the length doesn't match.
> + */
> +static inline int _len_memstrcmp(const u8 *mem, size_t mem_len, const ch=
ar *str)
> +{
> +	size_t str_len =3D strlen(str);
> +
> +	return (mem_len !=3D str_len) || memcmp(mem, str, str_len);
> +}
> +
> +/* Assumes elm->lock taken. */
> +static void elm327_parse_error(struct elmcan *elm, size_t len)
> +{
> +	struct can_frame frame;
> +
> +	memset(&frame, 0, sizeof(frame));
> +	frame.can_id =3D CAN_ERR_FLAG;
> +	frame.can_dlc =3D CAN_ERR_DLC;
> +
> +	/* Filter possible error messages based on length of RX'd line */
> +	if (!_len_memstrcmp(elm->rxbuf, len, "UNABLE TO CONNECT")) {
> +		netdev_err(elm->dev,
> +			   "ELM327 reported UNABLE TO CONNECT. Please check your setup.\n");
> +	} else if (!_len_memstrcmp(elm->rxbuf, len, "BUFFER FULL")) {
> +		/* This will only happen if the last data line was complete.
> +		 * Otherwise, elm327_parse_frame() will heuristically
> +		 * emit this kind of error frame instead.
> +		 */
> +		frame.can_id |=3D CAN_ERR_CRTL;
> +		frame.data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +	} else if (!_len_memstrcmp(elm->rxbuf, len, "BUS ERROR")) {
> +		frame.can_id |=3D CAN_ERR_BUSERROR;
> +	} else if (!_len_memstrcmp(elm->rxbuf, len, "CAN ERROR")) {
> +		frame.can_id |=3D CAN_ERR_PROT;
> +	} else if (!_len_memstrcmp(elm->rxbuf, len, "<RX ERROR")) {
> +		frame.can_id |=3D CAN_ERR_PROT;
> +	} else if (!_len_memstrcmp(elm->rxbuf, len, "BUS BUSY")) {
> +		frame.can_id |=3D CAN_ERR_PROT;
> +		frame.data[2] =3D CAN_ERR_PROT_OVERLOAD;
> +	} else if (!_len_memstrcmp(elm->rxbuf, len, "FB ERROR")) {
> +		frame.can_id |=3D CAN_ERR_PROT;
> +		frame.data[2] =3D CAN_ERR_PROT_TX;
> +	} else if (len =3D=3D 5 && !_memstrcmp(elm->rxbuf, "ERR")) {
> +		/* ERR is followed by two digits, hence line length 5 */
> +		netdev_err(elm->dev, "ELM327 reported an ERR%c%c. Please power it off =
and on again.\n",
> +			   elm->rxbuf[3], elm->rxbuf[4]);
> +		frame.can_id |=3D CAN_ERR_CRTL;
> +	} else {
> +		/* Something else has happened.
> +		 * Maybe garbage on the UART line.
> +		 * Emit a generic error frame.
> +		 */
> +	}
> +
> +	elm327_feed_frame_to_netdev(elm, &frame);
> +}
> +
> +/* Parse CAN frames coming as ASCII from ELM327.
> + * They can be of various formats:
> + *
> + * 29-bit ID (EFF):  12 34 56 78 D PL PL PL PL PL PL PL PL
> + * 11-bit ID (!EFF): 123 D PL PL PL PL PL PL PL PL
> + *
> + * where D =3D DLC, PL =3D payload byte
> + *
> + * Instead of a payload, RTR indicates a remote request.
> + *
> + * We will use the spaces and line length to guess the format.
> + *
> + * Assumes elm->lock taken.
> + */
> +static int elm327_parse_frame(struct elmcan *elm, size_t len)
> +{
> +	struct can_frame frame;
> +	int hexlen;
> +	int datastart;
> +	int i;
> +
> +	memset(&frame, 0, sizeof(frame));

please directly allocate an skb and fill it

> +
> +	/* Find first non-hex and non-space character:
> +	 *  - In the simplest case, there is none.
> +	 *  - For RTR frames, 'R' is the first non-hex character.
> +	 *  - An error message may replace the end of the data line.
> +	 */
> +	for (hexlen =3D 0; hexlen <=3D len; hexlen++) {
> +		if (hex_to_bin(elm->rxbuf[hexlen]) < 0 &&
> +		    elm->rxbuf[hexlen] !=3D ' ') {
> +			break;
> +		}
> +	}
> +
> +	/* Sanity check whether the line is really a clean hexdump,
> +	 * or terminated by an error message, or contains garbage.
> +	 */
> +	if (hexlen < len &&
> +	    !isdigit(elm->rxbuf[hexlen]) &&
> +	    !isupper(elm->rxbuf[hexlen]) &&
> +	    '<' !=3D elm->rxbuf[hexlen] &&
> +	    ' ' !=3D elm->rxbuf[hexlen]) {
> +		/* The line is likely garbled anyway, so bail.
> +		 * The main code will restart listening.
> +		 */
> +		return -ENODATA;
> +	}
> +
> +	/* Use spaces in CAN ID to distinguish 29 or 11 bit address length.
> +	 * No out-of-bounds access:
> +	 * We use the fact that we can always read from elm->rxbuf.
> +	 */
> +	if (elm->rxbuf[2] =3D=3D ' ' && elm->rxbuf[5] =3D=3D ' ' &&
> +	    elm->rxbuf[8] =3D=3D ' ' && elm->rxbuf[11] =3D=3D ' ' &&
> +	    elm->rxbuf[13] =3D=3D ' ') {
> +		frame.can_id =3D CAN_EFF_FLAG;
> +		datastart =3D 14;
> +	} else if (elm->rxbuf[3] =3D=3D ' ' && elm->rxbuf[5] =3D=3D ' ') {
> +		frame.can_id =3D 0;

nitpick: it's already 0

> +		datastart =3D 6;
> +	} else {
> +		/* This is not a well-formatted data line.
> +		 * Assume it's an error message.
> +		 */
> +		return -ENODATA;
> +	}
> +
> +	if (hexlen < datastart) {
> +		/* The line is too short to be a valid frame hex dump.
> +		 * Something interrupted the hex dump or it is invalid.
> +		 */
> +		return -ENODATA;
> +	}
> +
> +	/* From here on all chars up to buf[hexlen] are hex or spaces,
> +	 * at well-defined offsets.
> +	 */
> +
> +	/* Read CAN data length */
> +	frame.can_dlc =3D (hex_to_bin(elm->rxbuf[datastart - 2]) << 0);
> +
> +	/* Read CAN ID */
> +	if (frame.can_id & CAN_EFF_FLAG) {
> +		frame.can_id |=3D (hex_to_bin(elm->rxbuf[0]) << 28)
> +			      | (hex_to_bin(elm->rxbuf[1]) << 24)
> +			      | (hex_to_bin(elm->rxbuf[3]) << 20)
> +			      | (hex_to_bin(elm->rxbuf[4]) << 16)
> +			      | (hex_to_bin(elm->rxbuf[6]) << 12)
> +			      | (hex_to_bin(elm->rxbuf[7]) << 8)
> +			      | (hex_to_bin(elm->rxbuf[9]) << 4)
> +			      | (hex_to_bin(elm->rxbuf[10]) << 0);
> +	} else {
> +		frame.can_id |=3D (hex_to_bin(elm->rxbuf[0]) << 8)
> +			      | (hex_to_bin(elm->rxbuf[1]) << 4)
> +			      | (hex_to_bin(elm->rxbuf[2]) << 0);
> +	}

Can you make use of hex2bin() here?

> +
> +	/* Check for RTR frame */
> +	if (elm->rxfill >=3D hexlen + 3 &&
> +	    !_memstrcmp(&elm->rxbuf[hexlen], "RTR")) {
> +		frame.can_id |=3D CAN_RTR_FLAG;
> +	}
> +
> +	/* Is the line long enough to hold the advertised payload?
> +	 * Note: RTR frames have a DLC, but no actual payload.
> +	 */
> +	if (!(frame.can_id & CAN_RTR_FLAG) &&
> +	    (hexlen < frame.can_dlc * 3 + datastart)) {
> +		/* Incomplete frame. */
> +
> +		/* Probably the ELM327's RS232 TX buffer was full.
> +		 * Emit an error frame and exit.
> +		 */
> +		frame.can_id =3D CAN_ERR_FLAG | CAN_ERR_CRTL;
> +		frame.can_dlc =3D CAN_ERR_DLC;
> +		frame.data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +		elm327_feed_frame_to_netdev(elm, &frame);
> +
> +		/* Signal failure to parse.
> +		 * The line will be re-parsed as an error line, which will fail.
> +		 * However, this will correctly drop the state machine back into
> +		 * command mode.
> +		 */
> +		return -ENODATA;
> +	}
> +
> +	/* Parse the data nibbles. */
> +	for (i =3D 0; i < frame.can_dlc; i++) {
> +		frame.data[i] =3D (hex_to_bin(elm->rxbuf[datastart + 3*i]) << 4)
> +			      | (hex_to_bin(elm->rxbuf[datastart + 3*i + 1]));

hex2bin()?

> +	}
> +
> +	/* Feed the frame to the network layer. */
> +	elm327_feed_frame_to_netdev(elm, &frame);
> +
> +	return 0;
> +}
> +
> +/* Assumes elm->lock taken. */
> +static void elm327_parse_line(struct elmcan *elm, size_t len)
> +{
> +	/* Skip empty lines */
> +	if (!len)
> +		return;
> +
> +	/* Skip echo lines */
> +	if (elm->drop_next_line) {
> +		elm->drop_next_line =3D 0;
> +		return;
> +	} else if (!_memstrcmp(elm->rxbuf, "AT")) {
> +		return;
> +	}
> +
> +	/* Regular parsing */
> +	switch (elm->state) {
> +	case ELM_RECEIVING:
> +		if (elm327_parse_frame(elm, len)) {
> +			/* Parse an error line. */
> +			elm327_parse_error(elm, len);
> +
> +			/* Start afresh. */
> +			elm327_kick_into_cmd_mode(elm);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +/* Assumes elm->lock taken. */
> +static void elm327_handle_prompt(struct elmcan *elm)
> +{
> +	struct can_frame *frame =3D &elm->can_frame;
> +	char local_txbuf[20];

How can you be sure, that the local_txbuf is large enough?
> +
> +	if (!elm->cmds_todo) {
> +		/* Enter CAN monitor mode */
> +		elm327_send(elm, "ATMA\r", 5);
> +		elm->state =3D ELM_RECEIVING;
> +
> +		return;
> +	}
> +
> +	/* Reconfigure ELM327 step by step as indicated by elm->cmds_todo */
> +	if (test_bit(TODO_INIT, &elm->cmds_todo)) {
> +		strcpy(local_txbuf, *elm->next_init_cmd);

strncpy()

> +
> +		elm->next_init_cmd++;
> +		if (!(*elm->next_init_cmd)) {
> +			clear_bit(TODO_INIT, &elm->cmds_todo);
> +			/* Init finished. */
> +		}
> +
> +	} else if (test_and_clear_bit(TODO_SILENT_MONITOR, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATCSM%i\r",
> +			!(!(elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)));

snprintf()

> +
> +	} else if (test_and_clear_bit(TODO_RESPONSES, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATR%i\r",
> +			!(elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY));
> +
> +	} else if (test_and_clear_bit(TODO_CAN_CONFIG, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATPC\r");
> +		set_bit(TODO_CAN_CONFIG_PART2, &elm->cmds_todo);
> +
> +	} else if (test_and_clear_bit(TODO_CAN_CONFIG_PART2, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATPB%04X\r",
> +			elm->can_config);
> +
> +	} else if (test_and_clear_bit(TODO_CANID_29BIT_HIGH, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATCP%02X\r",
> +			(frame->can_id & CAN_EFF_MASK) >> 24);
> +
> +	} else if (test_and_clear_bit(TODO_CANID_29BIT_LOW, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATSH%06X\r",
> +			frame->can_id & CAN_EFF_MASK & ((1 << 24) - 1));
> +
> +	} else if (test_and_clear_bit(TODO_CANID_11BIT, &elm->cmds_todo)) {
> +		sprintf(local_txbuf, "ATSH%03X\r",
> +			frame->can_id & CAN_SFF_MASK);
> +
> +	} else if (test_and_clear_bit(TODO_CAN_DATA, &elm->cmds_todo)) {
> +		if (frame->can_id & CAN_RTR_FLAG) {
> +			/* Send an RTR frame. Their DLC is fixed.
> +			 * Some chips don't send them at all.
> +			 */
> +			sprintf(local_txbuf, "ATRTR\r");
> +		} else {
> +			/* Send a regular CAN data frame */
> +			int i;
> +
> +			for (i =3D 0; i < frame->can_dlc; i++) {
> +				sprintf(&local_txbuf[2 * i], "%02X",
> +					frame->data[i]);
> +			}
> +
> +			sprintf(&local_txbuf[2 * i], "\r");
> +		}
> +
> +		elm->drop_next_line =3D 1;
> +		elm->state =3D ELM_RECEIVING;
> +	}
> +
> +	elm327_send(elm, local_txbuf, strlen(local_txbuf));
> +}
> +
> +static bool elm327_is_ready_char(char c)
> +{
> +	/* Bits 0xc0 are sometimes set (randomly), hence the mask.
> +	 * Probably bad hardware.
> +	 */
> +	return (c & 0x3f) =3D=3D ELM327_READY_CHAR;
> +}
> +
> +/* Assumes elm->lock taken. */
> +static void elm327_drop_bytes(struct elmcan *elm, size_t i)
> +{
> +	memmove(&elm->rxbuf[0], &elm->rxbuf[i], ELM327_SIZE_RXBUF - i);
> +	elm->rxfill -=3D i;
> +}
> +
> +/* Assumes elm->lock taken. */
> +static void elm327_parse_rxbuf(struct elmcan *elm)
> +{
> +	size_t len;
> +
> +	switch (elm->state) {
> +	case ELM_NOTINIT:
> +		elm->rxfill =3D 0;
> +		break;
> +
> +	case ELM_GETDUMMYCHAR:
> +	{
> +		/* Wait for 'y' or '>' */
> +		int i;
> +
> +		for (i =3D 0; i < elm->rxfill; i++) {
> +			if (elm->rxbuf[i] =3D=3D ELM327_DUMMY_CHAR) {
> +				elm327_send(elm, "\r", 1);
> +				elm->state =3D ELM_GETPROMPT;
> +				i++;
> +				break;
> +			} else if (elm327_is_ready_char(elm->rxbuf[i])) {
> +				elm327_send(elm, ELM327_DUMMY_STRING, 1);
> +				i++;
> +				break;
> +			}
> +		}
> +
> +		elm327_drop_bytes(elm, i);
> +
> +		break;
> +	}
> +
> +	case ELM_GETPROMPT:
> +		/* Wait for '>' */
> +		if (elm327_is_ready_char(elm->rxbuf[elm->rxfill - 1]))
> +			elm327_handle_prompt(elm);
> +
> +		elm->rxfill =3D 0;
> +		break;
> +
> +	case ELM_RECEIVING:
> +		/* Find <CR> delimiting feedback lines. */
> +		for (len =3D 0;
> +		     (len < elm->rxfill) && (elm->rxbuf[len] !=3D '\r');
> +		     len++) {
> +			/* empty loop */
> +		}
> +
> +		if (len =3D=3D ELM327_SIZE_RXBUF) {
> +			/* Line exceeds buffer. It's probably all garbage.
> +			 * Did we even connect at the right baud rate?
> +			 */
> +			netdev_err(elm->dev,
> +				   "RX buffer overflow. Faulty ELM327 or UART?\n");
> +			elm327_hw_failure(elm);
> +			break;
> +		} else if (len =3D=3D elm->rxfill) {
> +			if (elm327_is_ready_char(elm->rxbuf[elm->rxfill - 1])) {
> +				/* The ELM327's AT ST response timeout ran out,
> +				 * so we got a prompt.
> +				 * Clear RX buffer and restart listening.
> +				 */
> +				elm->rxfill =3D 0;
> +
> +				elm327_handle_prompt(elm);
> +				break;
> +			}
> +
> +			/* No <CR> found - we haven't received a full line yet.
> +			 * Wait for more data.
> +			 */
> +			break;
> +		}
> +
> +		/* We have a full line to parse. */
> +		elm327_parse_line(elm, len);
> +
> +		/* Remove parsed data from RX buffer. */
> +		elm327_drop_bytes(elm, len + 1);
> +
> +		/* More data to parse? */
> +		if (elm->rxfill)
> +			elm327_parse_rxbuf(elm);
> +	}
> +}
> +
> +/* Dummy needed to use can_rx_offload */
> +static struct sk_buff *elmcan_mailbox_read(struct can_rx_offload *offloa=
d,
> +					   unsigned int n, u32 *timestamp,
> +					   bool drop)
> +{
> +	WARN_ON_ONCE(1); /* This function is a dummy, so don't call it! */
> +
> +	return ERR_PTR(-ENOBUFS);
> +}
> +
> +static int elmcan_netdev_open(struct net_device *dev)
> +{
> +	struct elmcan *elm =3D netdev_priv(dev);
> +	int err;
> +
> +	spin_lock_bh(&elm->lock);
> +	if (elm->hw_failure) {
> +		netdev_err(elm->dev, "Refusing to open interface after a hardware faul=
t has been detected.\n");
> +		spin_unlock_bh(&elm->lock);
> +		return -EIO;
> +	}

How to recover from this error?

> +
> +	if (!elm->tty) {
> +		spin_unlock_bh(&elm->lock);
> +		return -ENODEV;
> +	}
> +
> +	/* open_candev() checks for elm->can.bittiming.bitrate !=3D 0 */
> +	err =3D open_candev(dev);
> +	if (err) {
> +		spin_unlock_bh(&elm->lock);
> +		return err;
> +	}
> +
> +	elm327_init(elm);
> +	spin_unlock_bh(&elm->lock);
> +
> +	elm->offload.mailbox_read =3D elmcan_mailbox_read;
> +	err =3D can_rx_offload_add_fifo(dev, &elm->offload, ELM327_NAPI_WEIGHT);
> +	if (err) {
> +		close_candev(dev);
> +		return err;
> +	}
> +
> +	can_rx_offload_enable(&elm->offload);
> +
> +	can_led_event(dev, CAN_LED_EVENT_OPEN);
> +	elm->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	netif_start_queue(dev);
> +
> +	return 0;
> +}
> +
> +static int elmcan_netdev_close(struct net_device *dev)
> +{
> +	struct elmcan *elm =3D netdev_priv(dev);
> +
> +	netif_stop_queue(dev);
> +
> +	spin_lock_bh(&elm->lock);
> +	if (elm->tty) {
> +		/* Interrupt whatever we're doing right now */
> +		elm327_send(elm, ELM327_DUMMY_STRING, 1);
> +
> +		/* Clear the wakeup bit, as the netdev will be down and thus
> +		 * the wakeup handler won't clear it
> +		 */
> +		clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
> +
> +		spin_unlock_bh(&elm->lock);
> +
> +		flush_work(&elm->tx_work);
> +	} else {
> +		spin_unlock_bh(&elm->lock);
> +	}
> +
> +	can_rx_offload_disable(&elm->offload);
> +	elm->can.state =3D CAN_STATE_STOPPED;
> +	can_rx_offload_del(&elm->offload);
> +	close_candev(dev);
> +	can_led_event(dev, CAN_LED_EVENT_STOP);
> +
> +	return 0;
> +}
> +
> +/* Send a can_frame to a TTY. */
> +static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
> +					    struct net_device *dev)
> +{
> +	struct elmcan *elm =3D netdev_priv(dev);
> +	struct can_frame *frame =3D (struct can_frame *)skb->data;
> +
> +	if (skb->len !=3D sizeof(struct can_frame))
> +		goto out;

replace by

        if (can_dropped_invalid_skb(ndev, skb))
		return NETDEV_TX_OK;

> +
> +	if (!netif_running(dev))  {
> +		netdev_warn(elm->dev, "xmit: iface is down.\n");
> +		goto out;
> +	}

How should this happen?

> +
> +	/* BHs are already disabled, so no spin_lock_bh().
> +	 * See Documentation/networking/netdevices.txt
> +	 */
> +	spin_lock(&elm->lock);
> +
> +	/* We shouldn't get here after a hardware fault:
> +	 * can_bus_off() calls netif_carrier_off()
> +	 */
> +	WARN_ON_ONCE(elm->hw_failure);
> +
> +	if (!elm->tty ||
> +	    elm->hw_failure ||
> +	    elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> +		spin_unlock(&elm->lock);
> +		goto out;
> +	}
> +
> +	netif_stop_queue(dev);
> +
> +	elm327_send_frame(elm, frame);
> +	spin_unlock(&elm->lock);
> +
> +	dev->stats.tx_packets++;
> +	dev->stats.tx_bytes +=3D frame->can_dlc;
> +
> +	can_led_event(dev, CAN_LED_EVENT_TX);
> +
> +out:
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops elmcan_netdev_ops =3D {
> +	.ndo_open	=3D elmcan_netdev_open,
> +	.ndo_stop	=3D elmcan_netdev_close,
> +	.ndo_start_xmit	=3D elmcan_netdev_start_xmit,
> +	.ndo_change_mtu	=3D can_change_mtu,
> +};
> +
> +/* Get a reference to our struct, taking into account locks/refcounts.
> + * This is to ensure ordering in case we are shutting down, and to ensure
> + * there is a refcount at all (otherwise tty->disc_data may be freed and
> + * before we increment the refcount).
> + * Use this for anything that can race against elmcan_ldisc_close().
> + */

Please have a look, mainline uses RCU:

| 0ace17d56824 can, slip: Protect tty->disc_data in write_wakeup and close =
with RCU

> +static struct elmcan *get_elm(struct tty_struct *tty)
> +{
> +	struct elmcan *elm;
> +	bool got_ref;
> +
> +	spin_lock_bh(&elmcan_discdata_lock);
> +	elm =3D (struct elmcan *)tty->disc_data;
> +
> +	if (!elm) {
> +		spin_unlock_bh(&elmcan_discdata_lock);
> +		return NULL;
> +	}
> +
> +	got_ref =3D atomic_inc_not_zero(&elm->refcount);
> +	spin_unlock_bh(&elmcan_discdata_lock);
> +
> +	if (!got_ref)
> +		return NULL;
> +
> +	return elm;
> +}
> +
> +static void put_elm(struct elmcan *elm)
> +{
> +	atomic_dec(&elm->refcount);
> +}
> +
> +static bool elmcan_is_valid_rx_char(char c)
> +{
> +	return (isdigit(c) ||
> +		isupper(c) ||
> +		c =3D=3D ELM327_DUMMY_CHAR ||
> +		c =3D=3D ELM327_READY_CHAR ||
> +		c =3D=3D '<' ||
> +		c =3D=3D 'a' ||
> +		c =3D=3D 'b' ||
> +		c =3D=3D 'v' ||
> +		c =3D=3D '.' ||
> +		c =3D=3D '?' ||
> +		c =3D=3D '\r' ||
> +		c =3D=3D ' ');
> +}
> +
> +/* Handle incoming ELM327 ASCII data.
> + * This will not be re-entered while running, but other ldisc
> + * functions may be called in parallel.
> + */
> +static void elmcan_ldisc_rx(struct tty_struct *tty,
> +			    const unsigned char *cp, const char *fp, int count)
> +{
> +	struct elmcan *elm =3D get_elm(tty);
> +
> +	if (!elm)
> +		return;
> +
> +	spin_lock_bh(&elm->lock);
> +
> +	if (elm->hw_failure)
> +		goto out;
> +
> +	while (count-- && elm->rxfill < ELM327_SIZE_RXBUF) {
> +		if (fp && *fp++) {
> +			netdev_err(elm->dev, "Error in received character stream. Check your =
wiring.");
> +
> +			elm327_hw_failure(elm);
> +
> +			goto out;
> +		}
> +
> +		/* Ignore NUL characters, which the PIC microcontroller may
> +		 * inadvertently insert due to a known hardware bug.
> +		 * See ELM327 documentation, which refers to a Microchip PIC
> +		 * bug description.
> +		 */
> +		if (*cp !=3D 0) {
> +			/* Check for stray characters on the UART line.
> +			 * Likely caused by bad hardware.
> +			 */
> +			if (!elmcan_is_valid_rx_char(*cp)) {
> +				netdev_err(elm->dev,
> +					   "Received illegal character %02x.\n",
> +					   *cp);
> +				elm327_hw_failure(elm);
> +
> +				goto out;
> +			}
> +
> +			elm->rxbuf[elm->rxfill++] =3D *cp;
> +		}
> +
> +		cp++;
> +	}
> +
> +	if (count >=3D 0) {
> +		netdev_err(elm->dev, "Receive buffer overflowed. Bad chip or wiring?");
> +
> +		elm327_hw_failure(elm);
> +
> +		goto out;
> +	}
> +
> +	elm327_parse_rxbuf(elm);
> +
> +out:
> +	spin_unlock_bh(&elm->lock);
> +	put_elm(elm);
> +}
> +
> +/* Write out remaining transmit buffer.
> + * Scheduled when TTY is writable.
> + */
> +static void elmcan_ldisc_tx_worker(struct work_struct *work)
> +{
> +	/* No need to use get_elm() here, as we'll always flush workers
> +	 * before destroying the elmcan object.
> +	 */
> +	struct elmcan *elm =3D container_of(work, struct elmcan, tx_work);
> +	ssize_t actual;
> +
> +	spin_lock_bh(&elm->lock);
> +	if (elm->hw_failure) {
> +		spin_unlock_bh(&elm->lock);
> +		return;
> +	}
> +
> +	if (!elm->tty || !netif_running(elm->dev)) {
> +		spin_unlock_bh(&elm->lock);
> +		return;
> +	}
> +
> +	if (elm->txleft <=3D 0)  {
> +		/* Our TTY write buffer is empty:
> +		 * Allow netdev to hand us another packet
> +		 */
> +		clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
> +		spin_unlock_bh(&elm->lock);
> +		netif_wake_queue(elm->dev);
> +		return;
> +	}
> +
> +	actual =3D elm->tty->ops->write(elm->tty, elm->txhead, elm->txleft);
> +	if (actual < 0) {
> +		netdev_err(elm->dev,
> +			   "Failed to write to tty %s.\n",
> +			   elm->tty->name);
> +		elm327_hw_failure(elm);
> +		spin_unlock_bh(&elm->lock);
> +		return;
> +	}
> +
> +	elm->txleft -=3D actual;
> +	elm->txhead +=3D actual;
> +	spin_unlock_bh(&elm->lock);
> +}
> +
> +/* Called by the driver when there's room for more data. */
> +static void elmcan_ldisc_tx_wakeup(struct tty_struct *tty)
> +{
> +	struct elmcan *elm =3D get_elm(tty);
> +
> +	if (!elm)
> +		return;
> +
> +	schedule_work(&elm->tx_work);
> +
> +	put_elm(elm);
> +}
> +
> +/* ELM327 can only handle bitrates that are integer divisors of 500 kHz,
> + * or 7/8 of that. Divisors are 1 to 64.
> + * Currently we don't implement support for 7/8 rates.
> + */
> +static const u32 elmcan_bitrate_const[64] =3D {
> +	 7812,  7936,  8064,  8196,  8333,  8474,  8620,  8771,
> +	 8928,  9090,  9259,  9433,  9615,  9803, 10000, 10204,
> +	10416, 10638, 10869, 11111, 11363, 11627, 11904, 12195,
> +	12500, 12820, 13157, 13513, 13888, 14285, 14705, 15151,
> +	15625, 16129, 16666, 17241, 17857, 18518, 19230, 20000,
> +	20833, 21739, 22727, 23809, 25000, 26315, 27777, 29411,
> +	31250, 33333, 35714, 38461, 41666, 45454, 50000, 55555,
> +	62500, 71428, 83333, 100000, 125000, 166666, 250000, 500000
> +};
> +
> +/* Dummy needed to use bitrate_const */
> +static int elmcan_do_set_bittiming(struct net_device *netdev)
> +{
> +	return 0;
> +}
> +
> +static int elmcan_ldisc_open(struct tty_struct *tty)
> +{
> +	struct net_device *dev;
> +	struct elmcan *elm;
> +	int err;
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	if (!tty->ops->write)
> +		return -EOPNOTSUPP;
> +
> +	dev =3D alloc_candev(sizeof(struct elmcan), 0);
> +	if (!dev)
> +		return -ENFILE;
> +	elm =3D netdev_priv(dev);
> +
> +	elm->txbuf =3D kmalloc(ELM327_SIZE_TXBUF, GFP_KERNEL);

Why do you allocate an extra buffer?

> +	if (!elm->txbuf) {
> +		err =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	/* Configure TTY interface */
> +	tty->receive_room =3D 65536; /* We don't flow control */
> +	elm->txleft =3D 0; /* Clear TTY TX buffer */
> +	spin_lock_init(&elm->lock);
> +	atomic_set(&elm->refcount, 1);
> +	INIT_WORK(&elm->tx_work, elmcan_ldisc_tx_worker);
> +
> +	/* Configure CAN metadata */
> +	elm->can.state =3D CAN_STATE_STOPPED;

net needed

> +	elm->can.bitrate_const =3D elmcan_bitrate_const;
> +	elm->can.bitrate_const_cnt =3D ARRAY_SIZE(elmcan_bitrate_const);
> +	elm->can.do_set_bittiming =3D elmcan_do_set_bittiming;
> +	elm->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY;
> +
> +	/* Configure netdev interface */
> +	elm->dev =3D dev;
> +	dev->netdev_ops =3D &elmcan_netdev_ops;
> +
> +	/* Mark ldisc channel as alive */
> +	elm->tty =3D tty;
> +	tty->disc_data =3D elm;
> +
> +	devm_can_led_init(elm->dev);
> +
> +	/* Let 'er rip */
> +	err =3D register_candev(elm->dev);
> +	if (err)
> +		goto out_err;
> +
> +	netdev_info(elm->dev, "elmcan on %s.\n", tty->name);
> +
> +	return 0;
> +
> +out_err:
> +	kfree(elm->txbuf);
> +	free_candev(elm->dev);
> +	return err;
> +}
> +
> +/* Close down an elmcan channel.
> + * This means flushing out any pending queues, and then returning.
> + * This call is serialized against other ldisc functions:
> + * Once this is called, no other ldisc function of ours is entered.
> + *
> + * We also use this function for a hangup event.
> + */
> +static void elmcan_ldisc_close(struct tty_struct *tty)
> +{
> +	struct elmcan *elm =3D get_elm(tty);
> +
> +	if (!elm)
> +		return;
> +
> +	/* unregister_netdev() calls .ndo_stop() so we don't have to. */
> +	unregister_candev(elm->dev);
> +
> +	/* Decrease the refcount twice, once for our own get_elm(),
> +	 * and once to remove the count of 1 that we set in _open().
> +	 * Once it reaches 0, we can safely destroy it.
> +	 */
> +	put_elm(elm);
> +	put_elm(elm);
> +
> +	while (atomic_read(&elm->refcount) > 0)
> +		msleep_interruptible(10);
> +
> +	/* At this point, all ldisc calls to us have become no-ops. */
> +
> +	flush_work(&elm->tx_work);
> +
> +	/* Mark channel as dead */
> +	spin_lock_bh(&elm->lock);
> +	tty->disc_data =3D NULL;
> +	elm->tty =3D NULL;
> +	spin_unlock_bh(&elm->lock);
> +
> +	netdev_info(elm->dev, "elmcan off %s.\n", tty->name);
> +
> +	kfree(elm->txbuf);
> +	free_candev(elm->dev);
> +}
> +
> +static void elmcan_ldisc_hangup(struct tty_struct *tty)
> +{
> +	elmcan_ldisc_close(tty);
> +}
> +
> +static int elmcan_ldisc_ioctl(struct tty_struct *tty,
> +			      unsigned int cmd, unsigned long arg)
> +{
> +	struct elmcan *elm =3D get_elm(tty);
> +	unsigned int tmp;
> +
> +	if (!elm)
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case SIOCGIFNAME:
> +		tmp =3D strnlen(elm->dev->name, IFNAMSIZ - 1) + 1;
> +		if (copy_to_user((void __user *)arg, elm->dev->name, tmp)) {
> +			put_elm(elm);
> +			return -EFAULT;
> +		}
> +
> +		put_elm(elm);
> +		return 0;
> +
> +	case SIOCSIFHWADDR:
> +		put_elm(elm);
> +		return -EINVAL;
> +
> +	default:
> +		put_elm(elm);
> +		return tty_mode_ioctl(tty, cmd, arg);
> +	}
> +}
> +
> +static struct tty_ldisc_ops elmcan_ldisc =3D {
> +	.owner		=3D THIS_MODULE,
> +	.name		=3D "elmcan",
> +	.num		=3D N_ELMCAN,
> +	.receive_buf	=3D elmcan_ldisc_rx,
> +	.write_wakeup	=3D elmcan_ldisc_tx_wakeup,
> +	.open		=3D elmcan_ldisc_open,
> +	.close		=3D elmcan_ldisc_close,
> +	.hangup		=3D elmcan_ldisc_hangup,
> +	.ioctl		=3D elmcan_ldisc_ioctl,
> +};
> +
> +static int __init elmcan_init(void)
> +{
> +	int status;
> +
> +	status =3D tty_register_ldisc(&elmcan_ldisc);
> +	if (status)
> +		pr_err("Can't register line discipline\n");
> +
> +	return status;
> +}
> +
> +static void __exit elmcan_exit(void)
> +{
> +	/* This will only be called when all channels have been closed by
> +	 * userspace - tty_ldisc.c takes care of the module's refcount.
> +	 */
> +	tty_unregister_ldisc(&elmcan_ldisc);
> +}
> +
> +module_init(elmcan_init);
> +module_exit(elmcan_exit);
> diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
> index 9d0f06bfbac3..bd034d0511f6 100644
> --- a/include/uapi/linux/tty.h
> +++ b/include/uapi/linux/tty.h
> @@ -38,8 +38,9 @@
>  #define N_NULL		27	/* Null ldisc used for error handling */
>  #define N_MCTP		28	/* MCTP-over-serial */
>  #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
> +#define N_ELMCAN	30	/* Serial / USB serial OBD-II Interfaces */
> =20
>  /* Always the newest line discipline + 1 */
> -#define NR_LDISCS	30
> +#define NR_LDISCS	31
> =20
>  #endif /* _UAPI_LINUX_TTY_H */
> --=20
> 2.30.2
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ameodlqutgf56yks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIvupAACgkQrX5LkNig
0112Sgf+KKyP5ou0jeakHglMRTHmKa0u7wo/Z6Cs7coyKt7BE1e8bJs0eJDFCgHW
6Ehd1ad3DKeUZzwcr2MD7EUI0zYONnZz1uxFx6R+DfDnxnT2ZfyZfN9bnHEP81Vw
X6U6acvs0rLqcm09s4XWwh5agdKaAsYrRd2R57YxDSepKCsjR8v1QMzhlAF2rR7y
tcF9iRbaXexaC2GORhg9KdiFfXb1GZg6MWEpmh7xoBdBLQjfXEOrcoUm+YPsPOsA
Ou1jO68aaP5vNo3f73ua9RsmFHi7D3n3iS+UHAuDHsvFXxRW6X/GxMb4k92gSDGF
b5VX2VOdg8qhheG9kv45wKeuZ7I/+w==
=qZqz
-----END PGP SIGNATURE-----

--ameodlqutgf56yks--
