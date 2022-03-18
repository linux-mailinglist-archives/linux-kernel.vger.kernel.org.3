Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C329E4DE09C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiCRSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiCRSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:01:51 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67C52B26
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:00:32 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id h126so17223010ybc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeVydUkA460G24f/qbyy3CSPbaRzmIObCdc2rLBWOhQ=;
        b=kNLz5wGk8HzaKB2i8WCjUFoyhxgxG13GPtfVJZPTvgm+l2JnpQtmNhlkxg9sz00CgU
         0KKNb9i/ASceW7z79RygD78SykhgXYXX82u+zI+5yqZk9Lr00kYB3dgtUGfMIfucp8N+
         ptDSFpctuhKbL9T7KBQGwOmjoyThRx/aZD7CfrMJ5qd2tvY9XYA36RO6Mu7P8QSAZPev
         lpF5jpNJLCKCjJDe8NJDs78pMnVWoBhW4ED2Iv3mheFhfA6DX6KPV/12czkw94Oi2sdj
         NajWYcRFPdi6qQUyR8IWujgXTNMEzn8QIHA1PtV12PFJ/gB0OV5ZgsEUXzd8ujgQ1ITf
         j5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeVydUkA460G24f/qbyy3CSPbaRzmIObCdc2rLBWOhQ=;
        b=4A+feNwfC58LVYGOQps6cRkCOb7ZL6yxUDJolmQdHveIhOiepi5J6dLpKCtIPNVG/t
         G+h7fxAFKuoZ3QXrYnI9itLDecPWAHQDU+N1ZZybkMP9FLnviY+foaWNJBmqVdfxq9IM
         /SQf9lFHe5rJb9ILjbsc9odgxKO2MMdgm76/8Ck5zcBc1KsNFqjZoZbPHraZvaBC5Qop
         6w/Kt/mUPjNwtzlg1m8BcnT0mgSzG2Vr3GZHQkPixlvwMOEviE5PxdxjzpxOFYj+Q3Jw
         Q+gcVEfzQRcw8znVC7spU56TD51UHJ9lHbb9dRdVybganFxWlP9o2tyhlavwZ9P9PZkp
         Ky7g==
X-Gm-Message-State: AOAM530MEdHSkNA9eys4OyNnX7yprkhGBVRBUm9yShP80I2r14THNcLS
        IHXYBxvMGjpFKqsu+ygurhxrDRwSHRSbxglymAf1Ew==
X-Google-Smtp-Source: ABdhPJxloxkv7YJ7jLIIoQ4BZKbMRZOulDLN9cUOA1MyU+5B/vqxzqfdZffImI8Pyd4ZWJmqXXZ2Iu68RjixZLhrlAQ=
X-Received: by 2002:a25:e697:0:b0:629:1f4a:5a3c with SMTP id
 d145-20020a25e697000000b006291f4a5a3cmr11004844ybh.228.1647626430198; Fri, 18
 Mar 2022 11:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220318165422.686848-1-linux@roeck-us.net> <CAC0y+AjJxRGE570hTAq4WEtFrWa71e9q_h4xyN_52o4b9G_r2g@mail.gmail.com>
In-Reply-To: <CAC0y+AjJxRGE570hTAq4WEtFrWa71e9q_h4xyN_52o4b9G_r2g@mail.gmail.com>
From:   Daisuke Nojiri <dnojiri@google.com>
Date:   Fri, 18 Mar 2022 11:00:19 -0700
Message-ID: <CAC0y+Ah+261R8LMMZOExjBMjOXcqkw5h4AyZCFSU093=7wxqqw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Re-introduce cros_ec_cmd_xfer and use
 it for ioctls
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Rob Barnes <robbarnes@google.com>,
        Rajat Jain <rajatja@google.com>,
        Brian Norris <briannorris@chromium.org>,
        Parth Malkan <parthmalkan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment looks good to me. The rest also looks good to me (based on
the FROMLIST patch on Gerrit).

Reviewed-by: Daisuke Nojiri <dnojiri@chromium.org>
On Fri, Mar 18, 2022 at 10:50 AM Daisuke Nojiri <dnojiri@google.com> wrote:
>
> The comment looks good to me. The rest also looks good to me (based on the FROMLIST patch on Gerrit).
>
> On Fri, Mar 18, 2022 at 9:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Commit 413dda8f2c6f ("platform/chrome: cros_ec_chardev: Use
>> cros_ec_cmd_xfer_status helper") inadvertendly changed the userspace ABI.
>> Previously, cros_ec ioctls would only report errors if the EC communication
>> failed, and otherwise return success and the result of the EC
>> communication. An EC command execution failure was reported in the EC
>> response field. The above mentioned commit changed this behavior, and the
>> ioctl itself would fail. This breaks userspace commands trying to analyze
>> the EC command execution error since the actual EC command response is no
>> longer reported to userspace.
>>
>> Fix the problem by re-introducing the cros_ec_cmd_xfer() helper, and use it
>> to handle ioctl messages.
>>
>> Fixes: 413dda8f2c6f ("platform/chrome: cros_ec_chardev: Use cros_ec_cmd_xfer_status helper")
>> Cc: Daisuke Nojiri <dnojiri@chromium.org>
>> Cc: Rob Barnes <robbarnes@google.com>
>> Cc: Rajat Jain <rajatja@google.com>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Parth Malkan <parthmalkan@google.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Updated comments / return value description. No functional change.
>>
>>  drivers/platform/chrome/cros_ec_chardev.c   |  2 +-
>>  drivers/platform/chrome/cros_ec_proto.c     | 50 +++++++++++++++++----
>>  include/linux/platform_data/cros_ec_proto.h |  3 ++
>>  3 files changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
>> index e0bce869c49a..fd33de546aee 100644
>> --- a/drivers/platform/chrome/cros_ec_chardev.c
>> +++ b/drivers/platform/chrome/cros_ec_chardev.c
>> @@ -301,7 +301,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
>>         }
>>
>>         s_cmd->command += ec->cmd_offset;
>> -       ret = cros_ec_cmd_xfer_status(ec->ec_dev, s_cmd);
>> +       ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
>>         /* Only copy data to userland if data was received. */
>>         if (ret < 0)
>>                 goto exit;
>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>> index c4caf2e2de82..ac1419881ff3 100644
>> --- a/drivers/platform/chrome/cros_ec_proto.c
>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>> @@ -560,22 +560,28 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>>  EXPORT_SYMBOL(cros_ec_query_all);
>>
>>  /**
>> - * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
>> + * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
>>   * @ec_dev: EC device.
>>   * @msg: Message to write.
>>   *
>> - * Call this to send a command to the ChromeOS EC. This should be used instead of calling the EC's
>> - * cmd_xfer() callback directly. It returns success status only if both the command was transmitted
>> - * successfully and the EC replied with success status.
>> + * Call this to send a command to the ChromeOS EC. This should be used instead
>> + * of calling the EC's cmd_xfer() callback directly. This function does not
>> + * convert EC command execution error codes to Linux error codes. Most
>> + * in-kernel users will want to use cros_ec_cmd_xfer_status() instead since
>> + * that function implements the conversion.
>>   *
>>   * Return:
>> - * >=0 - The number of bytes transferred
>> - * <0 - Linux error code
>> + * >0 - EC command was executed successfully. The return value is the number
>> + *      of bytes returned by the EC (excluding the header).
>> + * =0 - EC communication was successful. EC command execution results are
>> + *      reported in msg->result. The result will be EC_RES_SUCCESS if the
>> + *      command was executed successfully or report an EC command execution
>> + *      error.
>> + * <0 - EC communication error. Return value is the Linux error code.
>>   */
>> -int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>> -                           struct cros_ec_command *msg)
>> +int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
>>  {
>> -       int ret, mapped;
>> +       int ret;
>>
>>         mutex_lock(&ec_dev->lock);
>>         if (ec_dev->proto_version == EC_PROTO_VERSION_UNKNOWN) {
>> @@ -616,6 +622,32 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>         ret = send_command(ec_dev, msg);
>>         mutex_unlock(&ec_dev->lock);
>>
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(cros_ec_cmd_xfer);
>> +
>> +/**
>> + * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
>> + * @ec_dev: EC device.
>> + * @msg: Message to write.
>> + *
>> + * Call this to send a command to the ChromeOS EC. This should be used instead of calling the EC's
>> + * cmd_xfer() callback directly. It returns success status only if both the command was transmitted
>> + * successfully and the EC replied with success status.
>> + *
>> + * Return:
>> + * >=0 - The number of bytes transferred.
>> + * <0 - Linux error code
>> + */
>> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>> +                           struct cros_ec_command *msg)
>> +{
>> +       int ret, mapped;
>> +
>> +       ret = cros_ec_cmd_xfer(ec_dev, msg);
>> +       if (ret < 0)
>> +               return ret;
>> +
>>         mapped = cros_ec_map_error(msg->result);
>>         if (mapped) {
>>                 dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n",
>> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
>> index df3c78c92ca2..16931569adce 100644
>> --- a/include/linux/platform_data/cros_ec_proto.h
>> +++ b/include/linux/platform_data/cros_ec_proto.h
>> @@ -216,6 +216,9 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>>  int cros_ec_check_result(struct cros_ec_device *ec_dev,
>>                          struct cros_ec_command *msg);
>>
>> +int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>> +                    struct cros_ec_command *msg);
>> +
>>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>                             struct cros_ec_command *msg);
>>
>> --
>> 2.35.1
>>
