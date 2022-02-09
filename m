Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0394AF2A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiBIN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiBIN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:26:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD5BC06157B;
        Wed,  9 Feb 2022 05:26:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m18so4166264lfq.4;
        Wed, 09 Feb 2022 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IW3027pfUSm8X8tmMTkWj4yWyhv91/JivfpJiyQLiBg=;
        b=dJGf5y1jbDEGB+Vn9qR3NLT7COhV84jva29kDfvj+l7eW9998iE9RpMNz+X2TeNY9C
         mvEHNWx6P8ftvXRNLa4e3yf9gVinvu6TqF+CzK/eHU5XqbjhAjbo9f2bH3UnqbQCldtD
         W4tsgVV/gTDaY4pz4V4T7isDXPUu1ce4oaeZ3mAZIsvPd0MPRkZuNu1TfyK6Z8Tkq9RB
         IxROrQSnJvgWra3iiqeakdqaHvKxMBa22GAABo1exSwghIM5alZG3pJg4BFbGq5/37OA
         RKuM52e9KeuvqCh0uI8CBto3jGCP+yprlJMUk+YX+RRxtuWKPgebgo+yZF+AqXQ2bFsb
         xolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IW3027pfUSm8X8tmMTkWj4yWyhv91/JivfpJiyQLiBg=;
        b=M7CcQ1QotiwVNtyArI0VxNcDaqoEOci+/gQXDF7htc0zPZOtHWtXqJkh6rWy5T9Rt2
         m8HO2r4TFOhk3Gl6u4rHiJ/G64cRf1I+A4VK9htaMrH4cPP0yD8xsajqgNFb9MrSdIqa
         N0o8Vr5ufJOrdvc1PlcmFEkZXoRpTENJwibuPE1/eutiITZzZP4UBXS4sSDiddCneS4z
         81ez5KilDlLR8iOrro7313yG0ros0pbhQMG/mY0xwG19gJVxvvYdtoKMbK6bT/SfF9Xe
         mRytP9ff4i7J7Kt/OciZrjHnXYY8edvLX/YvIluzwA3D9mk6UHy/d/gUUFHNY4KBoQoy
         R9RA==
X-Gm-Message-State: AOAM533RFpsLc1+12ou9LuANvNqJmoHOUO6gdG68O2NWzndgksGPaH1r
        ITA1B2GPAxm0HI/2xviN5ile7Jfz1mLPypSJ+8gcp1Khav0=
X-Google-Smtp-Source: ABdhPJyPmCW0fruoHVDhJ8leSBxkGo9GErvI0neCMAQe/rZMisBmm0gPz/T5q89klmonQ+tV1p151TLatMpLwEMiPTc=
X-Received: by 2002:a05:6512:e9e:: with SMTP id bi30mr1716853lfb.554.1644413186402;
 Wed, 09 Feb 2022 05:26:26 -0800 (PST)
MIME-Version: 1.0
References: <1644246970-18305-1-git-send-email-u0084500@gmail.com>
 <1644246970-18305-3-git-send-email-u0084500@gmail.com> <YgO4+mB5xJ5DbX61@kuha.fi.intel.com>
In-Reply-To: <YgO4+mB5xJ5DbX61@kuha.fi.intel.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 9 Feb 2022 21:26:14 +0800
Message-ID: <CADiBU3_GuHapJMUen+Ag_JaapzbN6CaAm+RNxN8E16yg5k-O0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: rt1719: Add support for Richtek RT1719
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>, will_lin@richtek.com,
        th_chuang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2022=E5=B9=B42=
=E6=9C=889=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:52=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> Sorry, there is still one more problem that I realised - not your
> problem, but a problem with fw_devlink_purge_absent_suppliers()...
>
> On Mon, Feb 07, 2022 at 11:16:10PM +0800, cy_huang wrote:
> > +static int rt1719_probe(struct i2c_client *i2c)
> > +{
> > +     struct rt1719_data *data;
> > +     struct fwnode_handle *fwnode;
> > +     struct typec_capability typec_cap =3D { };
> > +     int ret;
> > +
> > +     data =3D devm_kzalloc(&i2c->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->dev =3D &i2c->dev;
> > +     init_completion(&data->req_completion);
> > +
> > +     data->regmap =3D devm_regmap_init_i2c(i2c, &rt1719_regmap_config)=
;
> > +     if (IS_ERR(data->regmap)) {
> > +             ret =3D PTR_ERR(data->regmap);
> > +             dev_err(&i2c->dev, "Failed to init regmap (%d)\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D rt1719_check_exist(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D rt1719_get_caps(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * This fwnode has a "compatible" property, but is never populate=
d as a
> > +      * struct device. Instead we simply parse it to read the properti=
es.
> > +      * This it breaks fw_devlink=3Don. To maintain backward compatibi=
lity
> > +      * with existing DT files, we work around this by deleting any
> > +      * fwnode_links to/from this fwnode.
> > +      */
> > +     fwnode =3D device_get_named_child_node(&i2c->dev, "connector");
> > +     if (!fwnode)
> > +             return -ENODEV;
> > +
> > +     fw_devlink_purge_absent_suppliers(fwnode);
>
> So don't use that function unless you really see some issue that it's
> fixing yourself.
>
> That function is broken. It breaks at least if the fwnode is shared -
> fwnodes can be, and are, shared - most likely it's broken in
> some other ways too. That function seems to be a hack for some
> individual problem that was caused by some deeper problem with the
> device links.
>
> We really need to figure out a fix for the core problem now instead of
> trying to come up with these hacks for every single separate scenario
> that is breaking because of the core problem, what ever that core
> problem may be.
>
OK, I'll remove it.

Originally, I think the others use it to solve fwlink problem.
But I didn't realize actually it's a workaround.
> > +     data->role_sw =3D fwnode_usb_role_switch_get(fwnode);
> > +     if (IS_ERR(data->role_sw)) {
> > +             ret =3D PTR_ERR(data->role_sw);
> > +             dev_err(&i2c->dev, "Failed to get usb role switch (%d)\n"=
, ret);
> > +             goto err_fwnode_put;
> > +     }
> > +
> > +     ret =3D devm_rt1719_psy_register(data);
> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to register psy (%d)\n", ret);
> > +             goto err_role_put;
> > +     }
> > +
> > +     typec_cap.revision =3D USB_TYPEC_REV_1_2;
> > +     typec_cap.pd_revision =3D 0x300;  /* USB-PD spec release 3.0 */
> > +     typec_cap.type =3D TYPEC_PORT_SNK;
> > +     typec_cap.data =3D TYPEC_PORT_DRD;
> > +     typec_cap.ops =3D &rt1719_port_ops;
> > +     typec_cap.fwnode =3D fwnode;
> > +     typec_cap.driver_data =3D data;
> > +     typec_cap.accessory[0] =3D TYPEC_ACCESSORY_DEBUG;
> > +
> > +     data->partner_desc.identity =3D &data->partner_ident;
> > +
> > +     data->port =3D typec_register_port(&i2c->dev, &typec_cap);
> > +     if (IS_ERR(data->port)) {
> > +             ret =3D PTR_ERR(data->port);
> > +             dev_err(&i2c->dev, "Failed to register typec port (%d)\n"=
, ret);
> > +             goto err_role_put;
> > +     }
> > +
> > +     ret =3D rt1719_init_attach_state(data);
> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to init attach state (%d)\n", =
ret);
> > +             goto err_role_put;
> > +     }
> > +
> > +     ret =3D rt1719_irq_init(data);
> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to init irq\n");
> > +             goto err_role_put;
> > +     }
> > +
> > +     fwnode_handle_put(fwnode);
> > +
> > +     i2c_set_clientdata(i2c, data);
> > +
> > +     return 0;
> > +
> > +err_role_put:
> > +     usb_role_switch_put(data->role_sw);
> > +err_fwnode_put:
> > +     fwnode_handle_put(fwnode);
> > +
> > +     return ret;
> > +}
> > +
> > +static int rt1719_remove(struct i2c_client *i2c)
> > +{
> > +     struct rt1719_data *data =3D i2c_get_clientdata(i2c);
> > +
> > +     typec_unregister_port(data->port);
> > +     usb_role_switch_put(data->role_sw);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id __maybe_unused rt1719_device_table[] =
=3D {
> > +     { .compatible =3D "richtek,rt1719", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, rt1719_device_table);
> > +
> > +static struct i2c_driver rt1719_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "rt1719",
> > +             .of_match_table =3D rt1719_device_table,
> > +     },
> > +     .probe_new =3D rt1719_probe,
> > +     .remove =3D rt1719_remove,
> > +};
> > +module_i2c_driver(rt1719_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("Richtek RT1719 Sink Only USBPD Controller Driver")=
;
> > +MODULE_LICENSE("GPL v2");
>
> Oh, you probable want the make that "GPL" instead. See
> Documentation/process/license-rules.rst.
>
Ack in next.
> thanks,
>
> --
> heikki
