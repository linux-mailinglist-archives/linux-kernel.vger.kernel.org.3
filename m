Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A11509222
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382553AbiDTVkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356105AbiDTVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:40:13 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06F536140
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:37:24 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650490642;
        bh=IMTEaCLkX65EaOGDF8JEGvzDdRQQF9214T4nBiguiKA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ePdmDlESgtZYOn3SVJgnY+HTI5tLpqwuJC6rjIBU3Evzfr+CBpKHv1LlcSqwUL336
         z/2C0R71UmbKSB/fXKC0AzuC+R5sjYLu6Q6/XDx1L+VpehWoce5g8nX3vJ5ecMYxEl
         zBo2zh7NSFzxGQDAxWQmrb0mmNsNuSDxk2MwRgPbqja9iq7qcX5OSaBK4+otix7S8d
         GqDDmNv/NsPvPANg+XZlZvv8opgCdgJBbgfS1S3lfLHg1pzcHg2SYf1nOIEcs6LY5a
         AOpeoiAbtxPScvzjAiERQ7j0i0Cm9s5QLVMxMLGCZN67aSwLPxz6nE4lBt3ll0hNQf
         Hd2rRvlC+iUGQ==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <Z-u0ylwQsRp0ZsoUL7G1kVcTsQy3yh6ozr4hWbv5ZsV16SIq_rQ6LlVHGWTpJwGubIyzYsmEyPoDkgVrvNgT8bQFTxldAk5oadd-2tuumsY=@wujek.eu>
In-Reply-To: <1b12cb3a-3d87-8254-b229-dcf83ad0bc0a@roeck-us.net>
References: <20220419215326.309991-1-dev_public@wujek.eu> <20220420122128.411757-1-dev_public@wujek.eu> <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net> <PFzjnraIDClF6umMOqlCKCzxG6q5lIhBLHpynRA6juh6gXSp5Y7SLPpzXZGNU6L7OGCEwl_F-niJn1jTflifWnqm9PX3Rcfqbtdo6rmPAT4=@wujek.eu> <6f697b2c-58aa-6ca4-966b-147bcc184dad@roeck-us.net> <Liq6d7nBil1lQx274diOvpjRJ9cEYH6co7ZMjrudPfYn0TTzOsfqsjuVBK-pMpFF5nBC0jhuoFEtbtmUY4Td4uY-a4qn6j-OmQD-Qu_xdck=@wujek.eu> <1b12cb3a-3d87-8254-b229-dcf83ad0bc0a@roeck-us.net>
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
On Wednesday, April 20th, 2022 at 18:06, Guenter Roeck <linux@roeck-us.net>=
 wrote:


>
>
> On 4/20/22 08:51, wujek dev wrote:
>
> > ------- Original Message -------
> > On Wednesday, April 20th, 2022 at 16:15, Guenter Roeck linux@roeck-us.n=
et wrote:
> >
> > > On 4/20/22 06:58, wujek dev wrote:
> > >
> > > > ------- Original Message -------
> > > > On Wednesday, April 20th, 2022 at 15:53, Guenter Roeck linux@roeck-=
us.net wrote:
> > > >
> > > > > On 4/20/22 05:22, Adam Wujek wrote:
> > > > >
> > > > > > Add registers to debugfs:
> > > > > > PMBUS_MFR_ID
> > > > > > PMBUS_MFR_MODEL
> > > > > > PMBUS_MFR_REVISION
> > > > > > PMBUS_MFR_LOCATION
> > > > > > PMBUS_MFR_DATE
> > > > > > PMBUS_MFR_SERIAL
> > > > > >
> > > > > > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > > > >
> > > > > Where is patch 1/2, and why did you resend this patch ?
> > > >
> > > > There should be no "1/2" since this and the second patch are unrela=
ted.
> > > > I resend it because I rebased it on master.
> > >
> > > Please provide change logs and version your patches in the future.
> > > ok, thank you for your patience.
> > >
> > > > Adam
> > > >
> > > > > Guenter
> > > > >
> > > > > > ---
> > > > > > drivers/hwmon/pmbus/pmbus_core.c | 84 +++++++++++++++++++++++++=
+++++++
> > > > > > 1 file changed, 84 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/p=
mbus/pmbus_core.c
> > > > > > index 0af7a3d74f47..1dc186780ccf 100644
> > > > > > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > > > > > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > > > > > @@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void=
 *data, u64 *val)
> > > > > > DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugf=
s_get_status,
> > > > > > NULL, "0x%04llx\n");
> > > > > >
> > > > > > +static ssize_t pmbus_debugfs_mfr_read(struct file *file, char =
__user *buf,
> > > > > > + size_t count, loff_t *ppos)
> > > > > > +{
> > > > > > + int rc;
> > > > > > + struct pmbus_debugfs_entry *entry =3D file->private_data;
> > > > > > + char data[I2C_SMBUS_BLOCK_MAX + 2] =3D { 0 };
> > > > > > +
> > > > > > + rc =3D i2c_smbus_read_block_data(entry->client, entry->reg, d=
ata);
> > > > > > + if (rc < 0)
> > > > > > + return rc;
> > > > > > +
> > > > > > + data[rc] =3D '\n';
> > > > > > + rc +=3D 2;
> > >
> > > Why +2 ?
> >
> > Copied from another driver.
> > +1 due to '\n'
> > +1 due to NULL character (smbus block transfer does not include it in t=
he length)
> > Explanation included in v3 patch.
>
>
> "copied from another driver" is not really a good argument.
> That other driver might just be buggy.
yes, you're right. There is a bug in that driver.
>
> What do you see in userspace when you read the data ? A string that ends =
with
> "\n\0" ? If so, does the "\0" at the end add any value ?
I confirm I see "\n\0". I will fix it right now. Thank you for pointing it =
out.

Adam
>
> Guenter
