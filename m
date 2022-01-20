Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601C49474C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358738AbiATG1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiATG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:27:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2F2C061574;
        Wed, 19 Jan 2022 22:27:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l16so4804019pjl.4;
        Wed, 19 Jan 2022 22:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6PnEEeRpS9P6EsumVvVkHj7TQIpevLQvEvfm6G+EUI=;
        b=EiCPcpGTHKufPpXRM4ILybZCsAEXwnYwvVzzpPAOGLHmba9CeTTCOuouI/81PSGzja
         h2xk1M8zo92rW89gN3hk6NAEIgHzDV8B3xnm7VcGUAg6dds/0JfhQ0LqE1TtJYwEPx6i
         yCiW3SKQc/c+oeQbjb7+ub8Ao9Vl7aB4JGR8aA4qB7NdLgTvrmMJLtNIdVnMWucc599T
         O62KEsP5D+HlUGC8RjoCVT4q+WoRt9nnjFg6LXQRN3Noz9aF942CBkcJevh6Ge+Ldp3J
         7lTRUmAQhq98ZFSdgCQglwToO2r9+zvCA42ydEQ+2UoBZnPdqmYoddDlhFjqq8WOTKeg
         fGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6PnEEeRpS9P6EsumVvVkHj7TQIpevLQvEvfm6G+EUI=;
        b=m9HqfrnmGuP4vs9Tfns4z1ousFaLrzEi0Otxqh54Qbd/w/2/d7KD/lCkt0s/igMZFw
         V7G1Yuwh/VlO7sTIW13xjJzVsHu6vbUpdNiZrO7CfA3zdsid5YIYIPGLfWWrNowBRX3L
         oHBSrT+ftAEJHPLVS+vD7TNP642sQvDdcO0yjsWd2943itFNDu7kDaXGVntSgpPZbfQ/
         zOXpQd4RznrhBNc9Qes8qqwPDbTwP/OK8nyKn8r7tPD8gE/4NwNHF0XE/HpunLjg61Xh
         xjIoPPVx9Jjq58JFR9jpB0YhNvVKAYvC1JqqjgsnJYPC0GhR/aLhJL5hvEx9QA2sr+dU
         2HCA==
X-Gm-Message-State: AOAM530EIC8MEdrusAe8zCQ46lT3xaYJ3R48+9NNLA5C+rMN9dFg+LqX
        hiCY1+MbdPWHO/sEvxL9I6UOMNq7Des=
X-Google-Smtp-Source: ABdhPJwLVxBi1A2z4EwAc0bx2yLG1O1xr1F38yWgjGScudvRPQiKnb7OFCO//OaeKq6cQYSf6kr+OA==
X-Received: by 2002:a17:902:a38a:b0:14a:d175:9b06 with SMTP id x10-20020a170902a38a00b0014ad1759b06mr13078913pla.64.1642660025017;
        Wed, 19 Jan 2022 22:27:05 -0800 (PST)
Received: from google.com ([2620:15c:202:201:1127:4705:9a89:489b])
        by smtp.gmail.com with ESMTPSA id s18sm1344531pgi.38.2022.01.19.22.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 22:27:03 -0800 (PST)
Date:   Wed, 19 Jan 2022 22:27:01 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Angela Czubak <acz@semihalf.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] HID: i2c-hid: explicitly code setting and sending
 reports
Message-ID: <YekAtZdCPNuxAD4N@google.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
 <20220118072628.1617172-6-dmitry.torokhov@gmail.com>
 <CAB4aORUaC+o+EWYUOc-mEjWfKTyhNH3ydgH_5QNkL4rObBr9pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB4aORUaC+o+EWYUOc-mEjWfKTyhNH3ydgH_5QNkL4rObBr9pQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angela,

On Wed, Jan 19, 2022 at 04:31:03PM +0100, Angela Czubak wrote:
> Hi Dmitry,
> 
> On Tue, Jan 18, 2022 at 8:26 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Instead of relying on __i2c_hid_command() that tries to handle all
> > commands and because of that is very complicated, let's define a
> > new dumb helper i2c_hid_xfer() that actually transfers (write and
> > read) data, and use it when sending and setting reports. By doing
> > that we can save on number of copy operations we have to execute,
> > and make logic of sending reports much clearer.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-core.c | 269 ++++++++++++++++-------------
> >  1 file changed, 151 insertions(+), 118 deletions(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> > index 6c1741d9211d..c48b75bd81e0 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/hid.h>
> >  #include <linux/mutex.h>
> > +#include <asm/unaligned.h>
> >
> >  #include "../hid-ids.h"
> >  #include "i2c-hid.h"
> > @@ -47,6 +48,15 @@
> >  #define I2C_HID_QUIRK_BAD_INPUT_SIZE           BIT(6)
> >  #define I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET    BIT(7)
> >
> > +/* Command opcodes */
> > +#define I2C_HID_OPCODE_RESET                   0x01
> > +#define I2C_HID_OPCODE_GET_REPORT              0x02
> > +#define I2C_HID_OPCODE_SET_REPORT              0x03
> > +#define I2C_HID_OPCODE_GET_IDLE                        0x04
> > +#define I2C_HID_OPCODE_SET_IDLE                        0x05
> > +#define I2C_HID_OPCODE_GET_PROTOCOL            0x06
> > +#define I2C_HID_OPCODE_SET_PROTOCOL            0x07
> > +#define I2C_HID_OPCODE_SET_POWER               0x08
> >
> >  /* flags */
> >  #define I2C_HID_STARTED                0
> > @@ -90,16 +100,6 @@ struct i2c_hid_cmd {
> >         unsigned int length;
> >  };
> >
> > -union command {
> > -       u8 data[0];
> > -       struct cmd {
> > -               __le16 reg;
> > -               __u8 reportTypeID;
> > -               __u8 opcode;
> > -               __u8 reportID;
> > -       } __packed c;
> > -};
> > -
> >  #define I2C_HID_CMD(opcode_) \
> >         .opcode = opcode_, .length = 4, \
> >         .registerIndex = offsetof(struct i2c_hid_desc, wCommandRegister)
> > @@ -115,9 +115,7 @@ static const struct i2c_hid_cmd hid_report_descr_cmd = {
> >  /* commands */
> >  static const struct i2c_hid_cmd hid_reset_cmd =                { I2C_HID_CMD(0x01) };
> >  static const struct i2c_hid_cmd hid_get_report_cmd =   { I2C_HID_CMD(0x02) };
> > -static const struct i2c_hid_cmd hid_set_report_cmd =   { I2C_HID_CMD(0x03) };
> >  static const struct i2c_hid_cmd hid_set_power_cmd =    { I2C_HID_CMD(0x08) };
> > -static const struct i2c_hid_cmd hid_no_cmd =           { .length = 0 };
> >
> >  /*
> >   * These definitions are not used here, but are defined by the spec.
> > @@ -144,7 +142,6 @@ struct i2c_hid {
> >         u8                      *inbuf;         /* Input buffer */
> >         u8                      *rawbuf;        /* Raw Input buffer */
> >         u8                      *cmdbuf;        /* Command buffer */
> > -       u8                      *argsbuf;       /* Command arguments buffer */
> >
> >         unsigned long           flags;          /* device flags */
> >         unsigned long           quirks;         /* Various quirks */
> > @@ -206,67 +203,90 @@ static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
> >         return quirks;
> >  }
> >
> > +static int i2c_hid_xfer(struct i2c_hid *ihid,
> > +                       u8 *send_buf, int send_len, u8 *recv_buf, int recv_len)
> > +{
> > +       struct i2c_client *client = ihid->client;
> > +       struct i2c_msg msgs[2] = { 0 };
> > +       int n = 0;
> > +       int ret;
> > +
> > +       if (send_len) {
> > +               i2c_hid_dbg(ihid, "%s: cmd=%*ph\n",
> > +                           __func__, send_len, send_buf);
> > +
> > +               msgs[n].addr = client->addr;
> > +               msgs[n].flags = client->flags & I2C_M_TEN;
> > +               msgs[n].len = send_len;
> > +               msgs[n].buf = send_buf;
> > +               n++;
> > +       }
> > +
> > +       if (recv_len) {
> > +               msgs[n].addr = client->addr;
> > +               msgs[n].flags = (client->flags & I2C_M_TEN) | I2C_M_RD;
> > +               msgs[n].len = recv_len;
> > +               msgs[n].buf = recv_buf;
> > +               n++;
> > +
> > +               set_bit(I2C_HID_READ_PENDING, &ihid->flags);
> > +       }
> > +
> > +       ret = i2c_transfer(client->adapter, msgs, n);
> > +
> > +       if (recv_len)
> > +               clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
> > +
> > +       if (ret != n)
> > +               return ret < 0 ? ret : -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static size_t i2c_hid_encode_command(u8 *buf, u8 opcode,
> > +                                    int report_type, int report_id)
> 
> Can it ever be used to encode something else than the command register?
> If not, perhaps we could fill it here as well.

It indeed always called after setting command register, however I
believe the register and command are logically distinct entities and
that it why I prefer not to handle the register here.

> 
> > +{
> > +       size_t length = 0;
> > +
> > +       if (report_id < 0x0F) {
> > +               buf[length++] = report_type << 4 | report_id;
> > +               buf[length++] = opcode;
> > +       } else {
> > +               buf[length++] = report_type << 4 | 0x0F;
> > +               buf[length++] = opcode;
> > +               buf[length++] = report_id;
> > +       }
> > +
> > +       return length;
> > +}
> > +
> >  static int __i2c_hid_command(struct i2c_hid *ihid,
> >                 const struct i2c_hid_cmd *command, u8 reportID,
> >                 u8 reportType, u8 *args, int args_len,
> >                 unsigned char *buf_recv, int data_len)
> >  {
> > -       struct i2c_client *client = ihid->client;
> > -       union command *cmd = (union command *)ihid->cmdbuf;
> > -       int ret;
> > -       struct i2c_msg msg[2];
> > -       int msg_num = 1;
> > -
> >         int length = command->length;
> >         unsigned int registerIndex = command->registerIndex;
> >
> >         /* special case for hid_descr_cmd */
> >         if (command == &hid_descr_cmd) {
> > -               cmd->c.reg = ihid->wHIDDescRegister;
> > +               *(__le16 *)ihid->cmdbuf = ihid->wHIDDescRegister;
> >         } else {
> > -               cmd->data[0] = ihid->hdesc_buffer[registerIndex];
> > -               cmd->data[1] = ihid->hdesc_buffer[registerIndex + 1];
> > +               ihid->cmdbuf[0] = ihid->hdesc_buffer[registerIndex];
> > +               ihid->cmdbuf[1] = ihid->hdesc_buffer[registerIndex + 1];
> >         }
> >
> >         if (length > 2) {
> > -               cmd->c.opcode = command->opcode;
> > -               if (reportID < 0x0F) {
> > -                       cmd->c.reportTypeID = reportType << 4 | reportID;
> > -               } else {
> > -                       cmd->c.reportTypeID = reportType << 4 | 0x0F;
> > -                       cmd->c.reportID = reportID;
> > -                       length++;
> > -               }
> > +               length = sizeof(__le16) + /* register */
> > +                        i2c_hid_encode_command(ihid->cmdbuf + sizeof(__le16),
> > +                                               command->opcode,
> > +                                               reportType, reportID);
> >         }
> >
> > -       memcpy(cmd->data + length, args, args_len);
> > +       memcpy(ihid->cmdbuf + length, args, args_len);
> >         length += args_len;
> >
> > -       i2c_hid_dbg(ihid, "%s: cmd=%*ph\n", __func__, length, cmd->data);
> > -
> > -       msg[0].addr = client->addr;
> > -       msg[0].flags = client->flags & I2C_M_TEN;
> > -       msg[0].len = length;
> > -       msg[0].buf = cmd->data;
> > -       if (data_len > 0) {
> > -               msg[1].addr = client->addr;
> > -               msg[1].flags = client->flags & I2C_M_TEN;
> > -               msg[1].flags |= I2C_M_RD;
> > -               msg[1].len = data_len;
> > -               msg[1].buf = buf_recv;
> > -               msg_num = 2;
> > -               set_bit(I2C_HID_READ_PENDING, &ihid->flags);
> > -       }
> > -
> > -       ret = i2c_transfer(client->adapter, msg, msg_num);
> > -
> > -       if (data_len > 0)
> > -               clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
> > -
> > -       if (ret != msg_num)
> > -               return ret < 0 ? ret : -EIO;
> > -
> > -       return 0;
> > +       return i2c_hid_xfer(ihid, ihid->cmdbuf, length, buf_recv, data_len);
> >  }
> >
> >  static int i2c_hid_command(struct i2c_hid *ihid,
> > @@ -301,70 +321,81 @@ static int i2c_hid_get_report(struct i2c_hid *ihid, u8 reportType,
> >         return 0;
> >  }
> >
> > +static size_t i2c_hid_format_report(u8 *buf, int report_id,
> > +                                   const u8 *data, size_t size)
> > +{
> > +       size_t length = sizeof(__le16); /* reserve space to store size */
> > +
> > +       if (report_id)
> > +               buf[length++] = report_id;
> > +
> > +       memcpy(buf + length, data, size);
> > +       length += size;
> > +
> > +       /* Store overall size in the beginning of the buffer */
> > +       put_unaligned_le16(length, buf);
> > +
> > +       return length;
> > +}
> > +
> >  /**
> >   * i2c_hid_set_or_send_report: forward an incoming report to the device
> >   * @ihid: the i2c hid device
> > - * @reportType: 0x03 for HID_FEATURE_REPORT ; 0x02 for HID_OUTPUT_REPORT
> > - * @reportID: the report ID
> > + * @report_type: 0x03 for HID_FEATURE_REPORT ; 0x02 for HID_OUTPUT_REPORT
> > + * @report_id: the report ID
> >   * @buf: the actual data to transfer, without the report ID
> >   * @data_len: size of buf
> > - * @use_data: true: use SET_REPORT HID command, false: send plain OUTPUT report
> > + * @do_set: true: use SET_REPORT HID command, false: send plain OUTPUT report
> >   */
> > -static int i2c_hid_set_or_send_report(struct i2c_hid *ihid, u8 reportType,
> > -               u8 reportID, unsigned char *buf, size_t data_len, bool use_data)
> > +static int i2c_hid_set_or_send_report(struct i2c_hid *ihid,
> > +                                     u8 report_type, u8 report_id,
> > +                                     const u8 *buf, size_t data_len,
> > +                                     bool do_set)
> >  {
> > -       u8 *args = ihid->argsbuf;
> > -       const struct i2c_hid_cmd *hidcmd;
> > -       int ret;
> > -       u16 dataRegister = le16_to_cpu(ihid->hdesc.wDataRegister);
> > -       u16 outputRegister = le16_to_cpu(ihid->hdesc.wOutputRegister);
> > -       u16 maxOutputLength = le16_to_cpu(ihid->hdesc.wMaxOutputLength);
> > -       u16 size;
> > -       int args_len;
> > -       int index = 0;
> > +       size_t length = 0;
> > +       int error;
> >
> >         i2c_hid_dbg(ihid, "%s\n", __func__);
> >
> >         if (data_len > ihid->bufsize)
> >                 return -EINVAL;
> >
> > -       size =          2                       /* size */ +
> > -                       (reportID ? 1 : 0)      /* reportID */ +
> > -                       data_len                /* buf */;
> > -       args_len =      2                       /* dataRegister */ +
> > -                       size                    /* args */;
> > -
> > -       if (!use_data && maxOutputLength == 0)
> > +       if (!do_set && le16_to_cpu(ihid->hdesc.wMaxOutputLength) == 0)
> >                 return -ENOSYS;
> >
> > -       /*
> > -        * use the data register for feature reports or if the device does not
> > -        * support the output register
> > -        */
> > -       if (use_data) {
> > -               args[index++] = dataRegister & 0xFF;
> > -               args[index++] = dataRegister >> 8;
> > -               hidcmd = &hid_set_report_cmd;
> > +       if (do_set) {
> > +               /* Command register goes first */
> > +               *(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
> > +               length += sizeof(__le16);
> > +               /* Next is SET_REPORT command */
> > +               length += i2c_hid_encode_command(ihid->cmdbuf + length,
> > +                                                I2C_HID_OPCODE_SET_REPORT,
> > +                                                report_type, report_id);
> > +               /*
> > +                * Report data will go into the data register. Because
> > +                * command can be either 2 or 3 bytes destination for
> > +                * the data register may be not aligned.
> > +               */
> > +               put_unaligned_le16(le16_to_cpu(ihid->hdesc.wDataRegister),
> > +                                  ihid->cmdbuf + length);
> > +               length += sizeof(__le16);
> >         } else {
> > -               args[index++] = outputRegister & 0xFF;
> > -               args[index++] = outputRegister >> 8;
> > -               hidcmd = &hid_no_cmd;
> > +               /*
> > +                * With simple "send report" all data goes into the output
> > +                * register.
> > +                */
> > +               *(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
> 
> I believe you meant ' *(__le16 *)ihid->cmdbuf = ihid->hdesc.wOutputRegister;' :)

Yes, indeed. Thank you for spotting this!

-- 
Dmitry
