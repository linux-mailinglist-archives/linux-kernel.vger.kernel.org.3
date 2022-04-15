Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFE502DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355891AbiDOQmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355877AbiDOQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:42:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204A8EB51;
        Fri, 15 Apr 2022 09:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87CDDB807E7;
        Fri, 15 Apr 2022 16:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84F0C385A6;
        Fri, 15 Apr 2022 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650040812;
        bh=ZPZH9abDj/HeoezpKxekPe1O0dK9m/nTbc77xsTr36s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F9tS8dpRW0skkCUT7ZHsTgL+6BWLKnKEPhnsejNIFMF6a4ixDDp6cqH/s4DkSP3DJ
         sxB4BDNSkad4g9le15hjq398vuZ83mzisfXSZlr5KMcTGuJHrS820cKAGvingDFgSO
         b5VCmeCBqDUuM9HikzrSPaAQUINsAjQzzEeqrU1DWvmtZY9/J41Dl6uuEA4E0r8ncg
         Ac1XNiZRo4cAOeQWg6epSYv2je6EIisZltK88yUVNAxQgeQ/1lu1PAVCbUk7ZtDJOk
         UlZsz/zmxYEnzNoc/cSbzUNQwYSXmE0yIYO8DXAHJW8ld2CF3n+f3WVDMLf7t8FCBe
         d+GpKl9gF2E/w==
Date:   Fri, 15 Apr 2022 17:48:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v4 12/14] iio: imu: add BNO055 serdev driver
Message-ID: <20220415174808.3b81baa4@jic23-huawei>
In-Reply-To: <20220415130005.85879-13-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
        <20220415130005.85879-13-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 15:00:03 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> From: Andrea Merello <andrea.merello@iit.it>
> 
> This path adds a serdev driver for communicating to a BNO055 IMU via
> serial bus, and it enables the BNO055 core driver to work in this
> scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Hi Andrea

A few really trivial things in here from me.

Jonathan

> ---

> diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> index 56cc4de60a7e..20128b1a1afc 100644
> --- a/drivers/iio/imu/bno055/Makefile
> +++ b/drivers/iio/imu/bno055/Makefile
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
> +obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_ser.o
> +
> +CFLAGS_bno055_ser.o := -I$(src)

Via a bit of grepping I can see other instances of this pattern which point out
that it's to do with allowing the tracing framework to see trace.h.
Perhaps a similar comment here would be good (if nothing else I doubt I'll
remember why this magic is here in a few years time!)

> diff --git a/drivers/iio/imu/bno055/bno055_ser.c b/drivers/iio/imu/bno055/bno055_ser.c
> new file mode 100644
> index 000000000000..360dfb0ee20a
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055_ser.c
> @@ -0,0 +1,556 @@
...

> +
> +struct bno055_ser_priv {
> +	struct serdev_device *serdev;
> +	struct completion cmd_complete;
> +	enum {
> +		CMD_NONE,
> +		CMD_READ,
> +		CMD_WRITE,
> +	} expect_response;
> +	int expected_data_len;
> +	u8 *response_buf;
> +
> +	/**
> +	 * enum cmd_status - represent the status of a command sent to the HW.
> +	 * @STATUS_CRIT: The command failed: the serial communication failed.
> +	 * @STATUS_OK:   The command executed successfully.
> +	 * @STATUS_FAIL: The command failed: HW responded with an error.
> +	 */
> +	enum {
> +		STATUS_CRIT = -1,
> +		STATUS_OK = 0,
> +		STATUS_FAIL = 1,
> +	} cmd_status;

Locks need documentation to say what scope they cover. In this case
I think it is most but not quite all of this structure.
See comment on completion below.

> +	struct mutex lock;
> +
> +	/* Only accessed in RX callback context. No lock needed. */
> +	struct {
> +		enum {
> +			RX_IDLE,
> +			RX_START,
> +			RX_DATA,
> +		} state;
> +		int databuf_count;
> +		int expected_len;
> +		int type;
> +	} rx;
> +
> +	/* Never accessed in behalf of RX callback context. No lock needed */
> +	bool cmd_stale;
> +};




...

> +
> +/*
> + * Handler for received data; this is called from the reicever callback whenever
> + * it got some packet from the serial bus. The status tell us whether the
> + * packet is valid (i.e. header ok && received payload len consistent wrt the
> + * header). It's now our responsability to check whether this is what we
> + * expected, of whether we got some unexpected, yet valid, packet.
> + */
> +static void bno055_ser_handle_rx(struct bno055_ser_priv *priv, int status)
> +{
> +	mutex_lock(&priv->lock);
> +	switch (priv->expect_response) {
> +	case CMD_NONE:
> +		dev_warn(&priv->serdev->dev, "received unexpected, yet valid, data from sensor");
> +		mutex_unlock(&priv->lock);
> +		return;
> +
> +	case CMD_READ:
> +		priv->cmd_status = status;
> +		if (status == STATUS_OK &&
> +		    priv->rx.databuf_count != priv->expected_data_len) {
> +			/*
> +			 * If we got here, then the lower layer serial protocol
> +			 * seems consistent with itself; if we got an unexpected
> +			 * amount of data then signal it as a non critical error
> +			 */
> +			priv->cmd_status = STATUS_FAIL;
> +			dev_warn(&priv->serdev->dev, "received an unexpected amount of, yet valid, data from sensor");

Wrap the line after dev,
Whilst it'll still be a very long line we can make it shorter with no loss
of readability, whilst still not breaking the string (which would make it hard
to grep for).

> +		}
> +		break;
> +
> +	case CMD_WRITE:
> +		priv->cmd_status = status;
> +		break;
> +	}
> +
> +	priv->expect_response = CMD_NONE;
> +	complete(&priv->cmd_complete);

I argued with myself a bit on whether the complete() should be inside the lock
or not - but then concluded it doesn't really matter and moving it out is
probably premature optimisation... Maybe it's worth moving it out simply
so that it's clear the lock isn't needed to protect it, or am I missing something?

> +	mutex_unlock(&priv->lock);
> +}
> +
> +/*
> + * Serdev receiver FSM. This tracks the serial communication and parse the
> + * header. It pushes packets to bno055_ser_handle_rx(), eventually communicating
> + * failures (i.e. malformed packets).
> + * Ideally it doesn't know anything about upper layer (i.e. if this is the
> + * packet we were really expecting), but since we copies the payload into the
> + * receiver buffer (that is not valid when i.e. we don't expect data), we
> + * snoop a bit in the upper layer..
> + * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
> + * unless we require to AND we don't queue more than one request per time).
> + */
> +static int bno055_ser_receive_buf(struct serdev_device *serdev,
> +				  const unsigned char *buf, size_t size)
> +{
> +	int status;
> +	struct bno055_ser_priv *priv = serdev_device_get_drvdata(serdev);
> +	int remaining = size;
> +
> +	if (size == 0)
> +		return 0;
> +
> +	trace_recv(size, buf);
> +	switch (priv->rx.state) {
> +	case RX_IDLE:
> +		/*
> +		 * New packet.
> +		 * Check for its 1st byte, that identifies the pkt type.
> +		 */
> +		if (buf[0] != 0xEE && buf[0] != 0xBB) {
> +			dev_err(&priv->serdev->dev,
> +				"Invalid packet start %x", buf[0]);
> +			bno055_ser_handle_rx(priv, STATUS_CRIT);
> +			break;
> +		}
> +		priv->rx.type = buf[0];
> +		priv->rx.state = RX_START;
> +		remaining--;
> +		buf++;
> +		priv->rx.databuf_count = 0;
> +		fallthrough;
> +
> +	case RX_START:
> +		/*
> +		 * Packet RX in progress, we expect either 1-byte len or 1-byte
> +		 * status depending by the packet type.
> +		 */
> +		if (remaining == 0)
> +			break;
> +
> +		if (priv->rx.type == 0xEE) {
> +			if (remaining > 1) {
> +				dev_err(&priv->serdev->dev, "EE pkt. Extra data received");
> +				status = STATUS_CRIT;

Trivial, but this blank line doesn't add anything so drop it.

> +
> +			} else {
> +				status = (buf[0] == 1) ? STATUS_OK : STATUS_FAIL;
> +			}
> +			bno055_ser_handle_rx(priv, status);
> +			priv->rx.state = RX_IDLE;
> +			break;
> +
> +		} else {
> +			/*priv->rx.type == 0xBB */
> +			priv->rx.state = RX_DATA;
> +			priv->rx.expected_len = buf[0];
> +			remaining--;
> +			buf++;
> +		}
> +		fallthrough;
> +
> +	case RX_DATA:
> +		/* Header parsed; now receiving packet data payload */
> +		if (remaining == 0)
> +			break;
> +
> +		if (priv->rx.databuf_count + remaining > priv->rx.expected_len) {
> +			/*
> +			 * This is a inconsistency in serial protocol, we lost

an inconsistency

> +			 * sync and we don't know how to handle further data
> +			 */
> +			dev_err(&priv->serdev->dev, "BB pkt. Extra data received");
> +			bno055_ser_handle_rx(priv, STATUS_CRIT);
> +			priv->rx.state = RX_IDLE;
> +			break;
> +		}
> +
> +		mutex_lock(&priv->lock);
> +		/*
> +		 * NULL e.g. when read cmd is stale or when no read cmd is
> +		 * actually pending.
> +		 */
> +		if (priv->response_buf &&
> +		    /*
> +		     * Snoop on the upper layer protocol stuff to make sure not
> +		     * to write to an invalid memory. Apart for this, let's the
> +		     * upper layer manage any inconsistency wrt expected data
> +		     * len (as long as the serial protocol is consistent wrt
> +		     * itself (i.e. response header is consistent with received
> +		     * response len.
> +		     */
> +		    (priv->rx.databuf_count + remaining <= priv->expected_data_len))
> +			memcpy(priv->response_buf + priv->rx.databuf_count,
> +			       buf, remaining);
> +		mutex_unlock(&priv->lock);
> +
> +		priv->rx.databuf_count += remaining;
> +
> +		/*
> +		 * Reached expected len advertised by the IMU for the current
> +		 * packet. Pass it to the upper layer (for us it is just valid).
> +		 */
> +		if (priv->rx.databuf_count == priv->rx.expected_len) {
> +			bno055_ser_handle_rx(priv, STATUS_OK);
> +			priv->rx.state = RX_IDLE;
> +		}
> +		break;
> +	}
> +
> +	return size;
> +}
