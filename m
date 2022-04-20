Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB845089EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379268AbiDTOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358948AbiDTOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:01:26 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E843497;
        Wed, 20 Apr 2022 06:58:39 -0700 (PDT)
Date:   Wed, 20 Apr 2022 13:58:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650463117;
        bh=W3/wkW5PX/t+tDDGms9gDWvuN5VQYe1ocPnfgFf/1e0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=afmyXuz4MRjgmby80LD+4aLz25pH0kXFyUHUoiL/uOGim16NSZvi6BfBwKHzvhmhy
         mRA6xpCdOeWtaquzBpx7of4DyW35hFDhCkSOkdRykFUsGcrFm+RrNZnP+uATy7JJYq
         vF+d34uvt7eXhzaNwZhsO1EIYwOBMVZk/tMJHrUOMIoLETyk1qMz09Qzd2Dgdrnw7E
         78B0bxVlQO/7RKRnqhzr3YDfKjrRvAtsxP2SrlDw9jzjYPX0G0u07uhoC0Q/iTkq2t
         Ks+30D3H0LE6hqeaNEyG8YRWCIQINe1ZiHILScoHmxmh8637+fu3ebWjK6051oN5y3
         2mhqMz0M6E+DA==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <PFzjnraIDClF6umMOqlCKCzxG6q5lIhBLHpynRA6juh6gXSp5Y7SLPpzXZGNU6L7OGCEwl_F-niJn1jTflifWnqm9PX3Rcfqbtdo6rmPAT4=@wujek.eu>
In-Reply-To: <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net>
References: <20220419215326.309991-1-dev_public@wujek.eu> <20220420122128.411757-1-dev_public@wujek.eu> <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, April 20th, 2022 at 15:53, Guenter Roeck <linux@roeck-us.net>=
 wrote:

>
>
> On 4/20/22 05:22, Adam Wujek wrote:
>
> > Add registers to debugfs:
> > PMBUS_MFR_ID
> > PMBUS_MFR_MODEL
> > PMBUS_MFR_REVISION
> > PMBUS_MFR_LOCATION
> > PMBUS_MFR_DATE
> > PMBUS_MFR_SERIAL
> >
> > Signed-off-by: Adam Wujek dev_public@wujek.eu
>
>
> Where is patch 1/2, and why did you resend this patch ?
>
There should be no "1/2" since this and the second patch are unrelated.
I resend it because I rebased it on master.

Adam

> Guenter
>
> > ---
> > drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
> > 1 file changed, 84 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmb=
us_core.c
> > index 0af7a3d74f47..1dc186780ccf 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void *data, =
u64 *val)
> > DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_st=
atus,
> > NULL, "0x%04llx\n");
> >
> > +static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *=
buf,
> > + size_t count, loff_t *ppos)
> > +{
> > + int rc;
> > + struct pmbus_debugfs_entry *entry =3D file->private_data;
> > + char data[I2C_SMBUS_BLOCK_MAX + 2] =3D { 0 };
> > +
> > + rc =3D i2c_smbus_read_block_data(entry->client, entry->reg, data);
> > + if (rc < 0)
> > + return rc;
> > +
> > + data[rc] =3D '\n';
> > + rc +=3D 2;
> > +
> > + return simple_read_from_buffer(buf, count, ppos, data, rc);
> > +}
> > +
> > +static const struct file_operations pmbus_debugfs_ops_mfr =3D {
> > + .llseek =3D noop_llseek,
> > + .read =3D pmbus_debugfs_mfr_read,
> > + .write =3D NULL,
> > + .open =3D simple_open,
> > +};
> > +
> > static int pmbus_debugfs_get_pec(void *data, u64 *val)
> > {
> > struct i2c_client *client =3D data;
> > @@ -2801,6 +2825,66 @@ static int pmbus_init_debugfs(struct i2c_client =
*client,
> > &entries[idx++],
> > &pmbus_debugfs_ops);
> > }
> > +
> > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_ID)) {
> > + entries[idx].client =3D client;
> > + entries[idx].page =3D i;
> > + entries[idx].reg =3D PMBUS_MFR_ID;
> > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_id", i);
> > + debugfs_create_file(name, 0444, data->debugfs,
> > + &entries[idx++],
> > + &pmbus_debugfs_ops_mfr);
> > + }
> > +
> > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_MODEL)) {
> > + entries[idx].client =3D client;
> > + entries[idx].page =3D i;
> > + entries[idx].reg =3D PMBUS_MFR_MODEL;
> > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_model", i);
> > + debugfs_create_file(name, 0444, data->debugfs,
> > + &entries[idx++],
> > + &pmbus_debugfs_ops_mfr);
> > + }
> > +
> > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_REVISION)) {
> > + entries[idx].client =3D client;
> > + entries[idx].page =3D i;
> > + entries[idx].reg =3D PMBUS_MFR_REVISION;
> > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_revision", i);
> > + debugfs_create_file(name, 0444, data->debugfs,
> > + &entries[idx++],
> > + &pmbus_debugfs_ops_mfr);
> > + }
> > +
> > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_LOCATION)) {
> > + entries[idx].client =3D client;
> > + entries[idx].page =3D i;
> > + entries[idx].reg =3D PMBUS_MFR_LOCATION;
> > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_location", i);
> > + debugfs_create_file(name, 0444, data->debugfs,
> > + &entries[idx++],
> > + &pmbus_debugfs_ops_mfr);
> > + }
> > +
> > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_DATE)) {
> > + entries[idx].client =3D client;
> > + entries[idx].page =3D i;
> > + entries[idx].reg =3D PMBUS_MFR_DATE;
> > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_date", i);
> > + debugfs_create_file(name, 0444, data->debugfs,
> > + &entries[idx++],
> > + &pmbus_debugfs_ops_mfr);
> > + }
> > +
> > + if (pmbus_check_byte_register(client, i, PMBUS_MFR_SERIAL)) {
> > + entries[idx].client =3D client;
> > + entries[idx].page =3D i;
> > + entries[idx].reg =3D PMBUS_MFR_SERIAL;
> > + scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_serial", i);
> > + debugfs_create_file(name, 0444, data->debugfs,
> > + &entries[idx++],
> > + &pmbus_debugfs_ops_mfr);
> > + }
> > }
> >
> > return devm_add_action_or_reset(data->dev,
> > --
> > 2.25.1
