Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A554C54B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347526AbiFOKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFOKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:00:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917A488A0;
        Wed, 15 Jun 2022 03:00:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e184so19597177ybf.8;
        Wed, 15 Jun 2022 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcgXdiyOSWY6YhfOwMKcuUVOe4Zo9OYs8PZ7t5HWb2s=;
        b=gKoJwzjf+0RM/6xR/PJQII5mqj52F24SXbMtNh+adgU722X44okol96QNpxaNTov8H
         gutV+VDue/kQNkDnx1st23E7xViKeXavK+HMLrPT2KuogRSgXu/wdna/xBRVPjmaXASQ
         Qsr5KAgGKw6ndWx6u+5AvRDtbQsvF5ZmLe8JmmgLe3TF75TTUodRGIy4mCwRePjOFFOi
         9P10vQhfhx0G0xPEuXjoKcs/kprSsN0DFTkIZduCy6XpaiPfmdMD1D9RbiViPeqpjOrH
         XjUGPL7m9YIWF4DGC4iXkAeSLgJLIaYU3LpSB+RM4hozFZ8gULDKqum7vvpes5Xxebly
         YYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcgXdiyOSWY6YhfOwMKcuUVOe4Zo9OYs8PZ7t5HWb2s=;
        b=JhBIEZGRGFHOo3mzke+tQX/dZu/SRM3VB+qAmseso0CW4DpeTvDH/PDLtdxyuPgCMY
         ZW9/aGg8WXeqxhxCB2PfyATb9IKo6TuH9n9UHtFWh8Qmb85MoW27WZv3yjBIKe/QRx0m
         EOq8r3/5OIt1/s6pXK0OLNvB79m9XuqyTzeoyXQarjAzNkvbFEM2+rX8edLoMnCIYBjt
         OX9S1sATo/szxof84Bfv5ec6tnU+v6wcBr4fL6bZQSkswzk4OqhpKxTD/9w7IT6Wo+KP
         K+IM79P0roEMq1VtwGpaMqUfzvNENLApgf7XvUNhuUPAbDTS83kCayPH9yIkufr6hqJQ
         FsaQ==
X-Gm-Message-State: AJIora9ND4b3YfWikSwZldH231KcFBHZgHDV1TNFT3CRA2JOwX29Lr8V
        oXNvSsZG62f8biHDBQlXTNb2d2GzL1AjfG8/SbP8LgyIIDk=
X-Google-Smtp-Source: AGRyM1sEHiA49OpbU9q1AtmrgQ43U2323enG36sQ4LQ7YlazhEyXNtA2LjrC2PtOprL5QhOL4yynrGaQ4ca3ResjivU=
X-Received: by 2002:a25:3145:0:b0:64e:ac9a:eb27 with SMTP id
 x66-20020a253145000000b0064eac9aeb27mr9225981ybx.630.1655287221425; Wed, 15
 Jun 2022 03:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220612152601.142314-1-max@enpas.org>
In-Reply-To: <20220612152601.142314-1-max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 15 Jun 2022 19:00:10 +0900
Message-ID: <CAMZ6RqLXouCXyt=OGm3GCXdnMJjnycz0BSwM6mcyXtAky_XOdQ@mail.gmail.com>
Subject: Re: [PATCH v8] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Because you will have to send a v9 for the split as requested by Marc,
let me through a last couple of nitpicks.

On Mon. 13 Jun 2022 at 00:26, Max Staudt <max@enpas.org> wrote:
> This is the can327 driver. It does a surprisingly good job at turning
> ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
> homebrew projects.
>
> Please see the included documentation for details and limitations:
> Documentation/networking/device_drivers/can/can327.rst
>
> Cc: linux-can <linux-can@vger.kernel.org>
> Signed-off-by: Max Staudt <max@enpas.org>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> After a through review (thanks to Vincent Mailhol), this is hopefully
> the last version of the can327 upstreaming patch.
>
> Thanks to everyone involved!
>
>
> Changes in v8:
>  - Rebased on linux-can-next
>  - Added "select CAN_RX_OFFLOAD" to Kconfig
>  - Removed CAN_CTRLMODE_LISTENONLY check, can_dropped_invalid_skb() does it.
>  - Removed CAN specific LED code.
>  - Print number of unhandled UART RX bytes on buffer overflow.
>  - The RX buffer is now 1024 bytes to handle huge buffers, such as
>    those found on FTDI USB-Serial bridges. In case the buffer is
>    ever too small again, this printk might give us a hint whether
>    it's truly a buffer sizing problem, or the buffer filling up
>    with garbage.
>    Thanks to frankiej911 for reporting and testing.
>  - Fixed memory leak in elm327_parse_frame() error cases.
>    Thanks Vincent!
>  - Don't count RTR frame DLC towards tx_bytes.
>  - Cleaned up can327.rst, as suggested by Vincent.
>  - Cleaned up stale includes and comments and array indices.
>
> Changes in v7:
>  - Accelerate parsing by not re-checking previous data
>      While waiting for a <CR> the code would search through previous
>      received characters, too. Keep track of what we've already
>      checked to speed this up.
>  - Speed up can327_is_valid_rx_char() with a LUT
>  - Make elm327_rxbuf_cmp() return bool
>  - Simplify/clarify branching and locking in several places
>  - Don't ____cacheline_aligned the TX buffer
>  - Style and comments cleanup
>
> Changes in v6:
>  - Renamed 'elmcan' to 'can327'

Some of the function or struct names are still prefixed with elm327,
some other with can327. Could you harmonize everything and use the
same prefix throughout the file?

>  - No other changes.
>
> Changes in v5:
>  - Fixed lockdep asserts (I didn't have lockdep enabled in my build)
>  - Restore: TTY wakeup request before write() in elm327_send()
>  - Clear TTY wakeup on uart_side_failure
>  - checkpatch style fixes
>  - Repack struct elmcan
>
> Changes in v4:
>  - Rebased on top of v5.18-rc5
>  - Simplified TTY locking.
>      The ldisc layer already blocks our ldisc ops from running concurrently.
>      No elm_get(), no RCU are needed, except locking against the TX worker.
>  - Removed .hangup() ldisc op which only called .close().
>      The ldisc layer calls .close() in a good place anyway.
>  - Restart on netdev down/up, even after UART failure.
>      This is in line with Marc's line of thinking, and there was no
>      good reason not to implement it. It also cleaned up the code.
>  - hw_failure is now uart_side_failure and shutdown looks closer to es58x.
>  - Clarified memory/string comparisons.
>      One helper function remains, but it's hopefully clear now :)
>  - lockdep_assert_held() instead of comments.
>  - Cleaned up types in struct elmcan and used pahole to pack it.
>      unsigned instead of int, u8 instead of char, ...
>  - The TX buffer is now a static part of struct elmcan. No more kmalloc().
>  - Removed dummy mailbox_read() for rx_offload.
>      by using can_rx_offload_add_manual() instead of can_rx_offload_add_fifo().
>  - netif_wake_queue() is moved to happen as late as possible.
>      Wake when the ELM327 is going into monitoring mode, not every time
>      after flushing whatever UART buffer we were TX'ing.
>  - Use alloc_can_skb() and avoid late allocation and copy.
>  - elmcan_netdev_start_xmit(): Used can_dropped_invalid_skb().
>  - Replaced ->can_dlc with ->len.
>  - Clarified size of local TX buffer in elm327_handle_prompt().
>  - Renamed TODO_* to ELM327_TX_DO_* and ELM_* to ELM327_STATE_*.
>  - Minor string and other cleanups.
>      pr_fmt, MODULE_*, unnecessary checks, ...
>  - Clarified file header.
>
> Changes in v3:
>  - Now depends on c2faf737abfb for new ldisc number 30.
>  - Eliminated hardcoded string lengths (GCC will work its magic).
>  - Emit generic error frames if an error message couldn't be parsed.
>  - Silence driver startup and init (but still announce ldattach).
>  - Cleaned up comments, strings, readme.
>  - Removed sole module option "accept_flaky_uart".
>    I likely had EMI in earlier testing, which is gone now.
>    This means we can stay strict, unless anyone objects.
>
> Changes in v2:
>  - Moved to SocketCAN's rx-offload wrapper for NAPI, thus avoiding
>    packets being reordered.
>  - Updated TTY ldisc code for Linux v5.17-rc3. A lot of cleanup has
>    happened there lately.
>  - netif_stop_queue() is called earlier in _netdev_close().
>  - Minor cleanup: More helpful strings and return values.
>
> ---
>  .../networking/device_drivers/can/can327.rst  |  331 +++++
>  .../networking/device_drivers/can/index.rst   |    1 +
>  MAINTAINERS                                   |    7 +
>  drivers/net/can/Kconfig                       |   18 +
>  drivers/net/can/Makefile                      |    1 +
>  drivers/net/can/can327.c                      | 1145 +++++++++++++++++
>  include/uapi/linux/tty.h                      |    3 +-
>  7 files changed, 1505 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/networking/device_drivers/can/can327.rst
>  create mode 100644 drivers/net/can/can327.c
>
> diff --git a/Documentation/networking/device_drivers/can/can327.rst b/Documentation/networking/device_drivers/can/can327.rst
> new file mode 100644
> index 000000000000..b87bfbe5d51c
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/can/can327.rst
> @@ -0,0 +1,331 @@
> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +
> +can327: ELM327 driver for Linux SocketCAN
> +==========================================
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
> +As such, can327 is a best effort driver. However, this is more than
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
> +How to attach the line discipline
> +----------------------------------
> +
> +Every ELM327 chip is factory programmed to operate at a serial setting
> +of 38400 baud/s, 8 data bits, no parity, 1 stopbit.
> +
> +If you have kept this default configuration, the line discipline can
> +be attached on a command prompt as follows::
> +
> +    sudo ldattach \
> +           --debug \
> +           --speed 38400 \
> +           --eightbits \
> +           --noparity \
> +           --onestopbit \
> +           --iflag -ICRNL,INLCR,-IXOFF \
> +           30 \
> +           /dev/ttyUSB0
> +
> +To change the ELM327's serial settings, please refer to its data
> +sheet. This needs to be done before attaching the line discipline.
> +
> +Once the ldisc is attached, the CAN interface starts out unconfigured.
> +Set the speed before starting it::
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
> +How to check the controller version
> +------------------------------------
> +
> +Use a terminal program to attach to the controller.
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
> +
> +Communication example
> +----------------------
> +
> +This is a short and incomplete introduction on how to talk to an ELM327.
> +It is here to guide understanding of the controller's and the driver's
> +limitation (listed below) as well as manual testing.
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
> +for, and are actually a hindrance for can327.
> +
> +
> +When a command is not recognized, such as by an older version of the
> +ELM327, a question mark is printed as a response instead of OK::
> +
> +    >ATUNKNOWN
> +    ?
> +    >
> +
> +At present, can327 does not evaluate this response. See the section
> +below on known limitations for details.
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
> +The above interaction sends the SFF frame "``DE AD BE EF 12 34 56 78``"
> +with (11 bit) CAN ID ``0x123``.
> +For this to function, the controller must be configured for SFF sending
> +mode (using "``AT PB``", see code or datasheet).
> +
> +
> +Once a frame has been sent and wait-for-reply mode is on (``ATR1``,
> +configured on ``listen-only=off``), or when the reply timeout expires
> +and the driver sets the controller into monitoring mode (``ATMA``),
> +the ELM327 will send one line for each received CAN frame, consisting
> +of CAN ID, DLC, and data::
> +
> +    123 8 DEADBEEF12345678
> +
> +For EFF (29 bit) CAN frames, the address format is slightly different,
> +which can327 uses to tell the two apart::
> +
> +    12 34 56 78 8 DEADBEEF12345678
> +
> +The ELM327 will receive both SFF and EFF frames - the current CAN
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
> +  "``AT CSM``" (CAN Silent Monitoring, i.e. don't send CAN ACKs) is
> +  not supported, and is hard coded to ON. Thus, frames are not ACKed
> +  while listening: "``AT MA``" (Monitor All) will always be "silent".
> +  However, immediately after sending a frame, the ELM327 will be in
> +  "receive reply" mode, in which it *does* ACK any received frames.
> +  Once the bus goes silent, or an error occurs (such as BUFFER FULL),
> +  or the receive reply timeout runs out, the ELM327 will end reply
> +  reception mode on its own and can327 will fall back to "``AT MA``"
> +  in order to keep monitoring the bus.
> +
> +  Other limitations may apply, depending on the clone and the quality
> +  of its firmware.
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
> +  These chips cannot be used at all with can327. They do not support
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
> diff --git a/Documentation/networking/device_drivers/can/index.rst b/Documentation/networking/device_drivers/can/index.rst
> index 0c3cc6633559..6a8a4f74fa26 100644
> --- a/Documentation/networking/device_drivers/can/index.rst
> +++ b/Documentation/networking/device_drivers/can/index.rst
> @@ -10,6 +10,7 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>
> +   can327
>     ctu/ctucanfd-driver
>     freescale/flexcan
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05fcbea3e432..baa92958e067 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7301,6 +7301,13 @@ L:       netdev@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/ibm/ehea/
>
> +ELM327 CAN NETWORK DRIVER
> +M:     Max Staudt <max@enpas.org>
> +L:     linux-can@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/networking/device_drivers/can/can327.rst
> +F:     drivers/net/can/can327.c
> +
>  EM28XX VIDEO4LINUX DRIVER
>  M:     Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:     linux-media@vger.kernel.org
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 806f15146f69..4078d0775572 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -113,6 +113,24 @@ config CAN_AT91
>           This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
>           and AT91SAM9X5 processors.
>
> +config CAN_CAN327
> +       tristate "Serial / USB serial ELM327 based OBD-II Interfaces (can327)"
> +       depends on TTY
> +       select CAN_RX_OFFLOAD
> +       help
> +         CAN driver for several 'low cost' OBD-II interfaces based on the
> +         ELM327 OBD-II interpreter chip.
> +
> +         This is a best effort driver - the ELM327 interface was never
> +         designed to be used as a standalone CAN interface. However, it can
> +         still be used for simple request-response protocols (such as OBD II),
> +         and to monitor broadcast messages on a bus (such as in a vehicle).
> +
> +         Please refer to the documentation for information on how to use it:
> +         Documentation/networking/device_drivers/can/can327.rst
> +
> +         If this driver is built as a module, it will be called can327.
> +
>  config CAN_FLEXCAN
>         tristate "Support for Freescale FLEXCAN based chips"
>         depends on OF || COLDFIRE || COMPILE_TEST
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 0af85983634c..cafa0e0a3dfe 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -14,6 +14,7 @@ obj-y                         += usb/
>  obj-y                          += softing/
>
>  obj-$(CONFIG_CAN_AT91)         += at91_can.o
> +obj-$(CONFIG_CAN_CAN327)       += can327.o
>  obj-$(CONFIG_CAN_CC770)                += cc770/
>  obj-$(CONFIG_CAN_C_CAN)                += c_can/
>  obj-$(CONFIG_CAN_CTUCANFD)     += ctucanfd/
> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> new file mode 100644
> index 000000000000..508378354b2c
> --- /dev/null
> +++ b/drivers/net/can/can327.c
> @@ -0,0 +1,1145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* ELM327 based CAN interface driver (tty line discipline)
> + *
> + * This driver started as a derivative of linux/drivers/net/can/slcan.c
> + * and my thanks go to the original authors for their inspiration.
> + *
> + * can327.c Author : Max Staudt <max-linux@enpas.org>
> + * slcan.c Author  : Oliver Hartkopp <socketcan@hartkopp.net>
> + * slip.c Authors  : Laurence Culhane <loz@holmes.demon.co.uk>
> + *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
> + */
> +
> +#define pr_fmt(fmt) "can327: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include <linux/bitops.h>
> +#include <linux/ctype.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
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
> +#include <linux/can/rx-offload.h>
> +
> +#define ELM327_NAPI_WEIGHT 4
> +
> +#define ELM327_SIZE_TXBUF 32
> +#define ELM327_SIZE_RXBUF 1024
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
> +enum elm327_tx_do {

enum can327_tx_do {

> +       ELM327_TX_DO_CAN_DATA = 0,

CAN327_TX_DO_CAN_DATA
(and so on)

> +       ELM327_TX_DO_CANID_11BIT,
> +       ELM327_TX_DO_CANID_29BIT_LOW,
> +       ELM327_TX_DO_CANID_29BIT_HIGH,
> +       ELM327_TX_DO_CAN_CONFIG_PART2,
> +       ELM327_TX_DO_CAN_CONFIG,
> +       ELM327_TX_DO_RESPONSES,
> +       ELM327_TX_DO_SILENT_MONITOR,
> +       ELM327_TX_DO_INIT
> +};
> +
> +struct can327 {
> +       /* This must be the first member when using alloc_candev() */
> +       struct can_priv can;
> +
> +       struct can_rx_offload offload;
> +
> +       /* TTY buffers */
> +       u8 txbuf[ELM327_SIZE_TXBUF];
> +       u8 rxbuf[ELM327_SIZE_RXBUF];
> +
> +       /* Per-channel lock */
> +       spinlock_t lock;
> +
> +       /* TTY and netdev devices that we're bridging */
> +       struct tty_struct *tty;
> +       struct net_device *dev;
> +
> +       /* TTY buffer accounting */
> +       struct work_struct tx_work;     /* Flushes TTY TX buffer */
> +       u8 *txhead;                     /* Next TX byte */
> +       size_t txleft;                  /* Bytes left to TX */
> +       int rxfill;                     /* Bytes already RX'd in buffer */
> +
> +       /* State machine */
> +       enum {
> +               ELM327_STATE_NOTINIT = 0,
> +               ELM327_STATE_GETDUMMYCHAR,
> +               ELM327_STATE_GETPROMPT,
> +               ELM327_STATE_RECEIVING,
> +       } state;
> +
> +       /* Things we have yet to send */
> +       char **next_init_cmd;
> +       unsigned long cmds_todo;
> +
> +       /* The CAN frame and config the ELM327 is sending/using,
> +        * or will send/use after finishing all cmds_todo
> +        */
> +       struct can_frame can_frame_to_send;
> +       u16 can_config;
> +       u8 can_bitrate_divisor;
> +
> +       /* Parser state */
> +       bool drop_next_line;
> +
> +       /* Stop the channel on UART side hardware failure, e.g. stray
> +        * characters or neverending lines. This may be caused by bad
> +        * UART wiring, a bad ELM327, a bad UART bridge...
> +        * Once this is true, nothing will be sent to the TTY.
> +        */
> +       bool uart_side_failure;
> +};
> +
> +static inline void elm327_uart_side_failure(struct can327 *elm);

static inline void can327_uart_side_failure(struct can327 *elm);
You got the idea so I will stop here.

> +
> +static void elm327_send(struct can327 *elm, const void *buf, size_t len)
> +{
> +       int written;
> +
> +       lockdep_assert_held(&elm->lock);
> +
> +       if (elm->uart_side_failure)
> +               return;
> +
> +       memcpy(elm->txbuf, buf, len);
> +
> +       /* Order of next two lines is *very* important.
> +        * When we are sending a little amount of data,
> +        * the transfer may be completed inside the ops->write()
> +        * routine, because it's running with interrupts enabled.
> +        * In this case we *never* got WRITE_WAKEUP event,
> +        * if we did not request it before write operation.
> +        *       14 Oct 1994  Dmitry Gorodchanin.
> +        */
> +       set_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
> +       written = elm->tty->ops->write(elm->tty, elm->txbuf, len);
> +       if (written < 0) {
> +               netdev_err(elm->dev,
> +                          "Failed to write to tty %s.\n",
> +                          elm->tty->name);
> +               elm327_uart_side_failure(elm);
> +               return;
> +       }
> +
> +       elm->txleft = len - written;
> +       elm->txhead = elm->txbuf + written;
> +}

[...]

> +/* Dummy needed to use bitrate_const */
> +static int can327_do_set_bittiming(struct net_device *netdev)
> +{
> +       return 0;
> +}

Seems you forgot to remove that guy :)
c.f. https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=7e193a42c37cf40eba8ac5af2d5e8eeb8b9506f9
