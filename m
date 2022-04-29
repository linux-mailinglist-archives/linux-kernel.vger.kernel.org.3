Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63291513FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353679AbiD2BHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353637AbiD2BHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:07:33 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44708BC853
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:14 -0700 (PDT)
Date:   Fri, 29 Apr 2022 01:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1651194251;
        bh=IjuQ8nW0w9/qVaqgZGfEGstuJBbXE45lxVUoYTmAsqs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=x/NyUJugKEoDIqjiA2wbVB+Dt5XeERRSPeSckW9CQ1eh9GAr9+kW+rmIeK8Hnyxfc
         yBjI9HfT5keEb7BF+oU+oRIe+CXZ0fuAj7EXaoKoMh/SO61W01ld+K5CjPuOurHAON
         hK/Bwas/ALuemr7Duuy9rACaMNaT1NRD2qwhQHycuLPne8UvgdjlDh/X4xL8ZGfw9D
         I+xvHy7JTB2F02SfGQCYAj4HgWFuJscIkRC/Bi/g42NZu7c3SS8v1KR2SYWFVgdOlW
         +gEUF003tRON6dDWNPCqm3uRGUqEyvUAJ/Snjo27rQEGwrZUnf3dgKNXwq3I11sS/g
         5nuY+dWx8EsEw==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH] hwmon: (pmbus) add missing definitions of pmbus registers
Message-ID: <hGgSY5dLHFlYeXpEkcTTRThFR76Eevb391giqk_CiNorL3WfRpH44if4pfaOu1jMc2GuB0T51wfbHj0Aiawd28p6HvuWN9t1bzY2S_D1_fM=@wujek.eu>
In-Reply-To: <f8ba6a46-bbdb-b8ba-7b27-d43f2e05426d@roeck-us.net>
References: <20220428134634.1610241-1-dev_public@wujek.eu> <f8ba6a46-bbdb-b8ba-7b27-d43f2e05426d@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>
> On 4/28/22 06:46, Adam Wujek wrote:
>
> > Definitions are taken from the table 31 of the PMBUS specification
> > revision 1.3.1, 13 March 2015.
>
>
> Do you plan to do anything with those registers, or a subset of it ?
yes, some of PMBUS_MFR_SPECIFIC_*, but in a driver that will not be publish=
ed in the near future.

Adam
>
> Guenter
>
> > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > ---
> > drivers/hwmon/pmbus/pmbus.h | 145 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 145 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> > index e74b6ef070f3..902bb9cce950 100644
> > --- a/drivers/hwmon/pmbus/pmbus.h
> > +++ b/drivers/hwmon/pmbus/pmbus.h
> > @@ -21,11 +21,29 @@ enum pmbus_regs {
> > PMBUS_ON_OFF_CONFIG =3D 0x02,
> > PMBUS_CLEAR_FAULTS =3D 0x03,
> > PMBUS_PHASE =3D 0x04,
> > + PMBUS_PAGE_PLUS_WRITE =3D 0x05,
> > + PMBUS_PAGE_PLUS_READ =3D 0x06,
> > + PMBUS_ZONE_CONFIG =3D 0x07,
> > + PMBUS_ZONE_ACTIVE =3D 0x08,
> > +
> > + /* 0x09 - 0x0F are reserved */
> >
> > PMBUS_WRITE_PROTECT =3D 0x10,
> > + PMBUS_STORE_DEFAULT_ALL =3D 0x11,
> > + PMBUS_RESTORE_DEFAULT_ALL =3D 0x12,
> > + PMBUS_STORE_DEFAULT_CODE =3D 0x13,
> > + PMBUS_RESTORE_DEFAULT_CODE =3D 0x14,
> > + PMBUS_STORE_USER_ALL =3D 0x15,
> > + PMBUS_RESTORE_USER_ALL =3D 0x16,
> > + PMBUS_STORE_USER_CODE =3D 0x17,
> > + PMBUS_RESTORE_USER_CODE =3D 0x18,
> >
> > PMBUS_CAPABILITY =3D 0x19,
> > +
> > PMBUS_QUERY =3D 0x1A,
> > + PMBUS_SMBALERT_MASK =3D 0x1B,
> > +
> > + /* 0x1C - 0x1F are reserved */
> >
> > PMBUS_VOUT_MODE =3D 0x20,
> > PMBUS_VOUT_COMMAND =3D 0x21,
> > @@ -38,10 +56,22 @@ enum pmbus_regs {
> > PMBUS_VOUT_DROOP =3D 0x28,
> > PMBUS_VOUT_SCALE_LOOP =3D 0x29,
> > PMBUS_VOUT_SCALE_MONITOR =3D 0x2A,
> > + PMBUS_VOUT_MIN =3D 0x2B,
> > +
> > + /* 0x2C - 0x2F are reserved */
> >
> > PMBUS_COEFFICIENTS =3D 0x30,
> > PMBUS_POUT_MAX =3D 0x31,
> >
> > + PMBUS_MAX_DUTY =3D 0x32,
> > + PMBUS_FREQUENCY_SWITCH =3D 0x33,
> > + PMBUS_POWER_MODE =3D 0x34,
> > + PMBUS_VIN_ON =3D 0x35,
> > + PMBUS_VIN_OFF =3D 0x36,
> > + PMBUS_INTERLEAVE =3D 0x37,
> > + PMBUS_IOUT_CAL_GAIN =3D 0x38,
> > + PMBUS_IOUT_CAL_OFFSET =3D 0x39,
> > +
> > PMBUS_FAN_CONFIG_12 =3D 0x3A,
> > PMBUS_FAN_COMMAND_1 =3D 0x3B,
> > PMBUS_FAN_COMMAND_2 =3D 0x3C,
> > @@ -63,6 +93,9 @@ enum pmbus_regs {
> > PMBUS_IOUT_UC_FAULT_LIMIT =3D 0x4B,
> > PMBUS_IOUT_UC_FAULT_RESPONSE =3D 0x4C,
> >
> > + /* 0x4D is reserved /
> > + / 0x4E is reserved */
> > +
> > PMBUS_OT_FAULT_LIMIT =3D 0x4F,
> > PMBUS_OT_FAULT_RESPONSE =3D 0x50,
> > PMBUS_OT_WARN_LIMIT =3D 0x51,
> > @@ -74,14 +107,28 @@ enum pmbus_regs {
> > PMBUS_VIN_OV_WARN_LIMIT =3D 0x57,
> > PMBUS_VIN_UV_WARN_LIMIT =3D 0x58,
> > PMBUS_VIN_UV_FAULT_LIMIT =3D 0x59,
> > + PMBUS_VIN_UV_FAULT_RESPONSE =3D 0x5A,
> >
> > PMBUS_IIN_OC_FAULT_LIMIT =3D 0x5B,
> > PMBUS_IIN_OC_WARN_LIMIT =3D 0x5D,
> >
> > + PMBUS_POWER_GOOD_ON =3D 0x5E,
> > + PMBUS_POWER_GOOD_OFF =3D 0x5F,
> > + PMBUS_TON_DELAY =3D 0x60,
> > + PMBUS_TON_RISE =3D 0x61,
> > + PMBUS_TON_MAX_FAULT_LIMIT =3D 0x62,
> > + PMBUS_TON_MAX_FAULT_RESPONSE =3D 0x63,
> > + PMBUS_TOFF_DELAY =3D 0x64,
> > + PMBUS_TOFF_FALL =3D 0x65,
> > + PMBUS_TOFF_MAX_WARN_LIMIT =3D 0x66,
> > + /* 0x67 is reserved (Was Used In PMBUS Revision 1.0) */
> > PMBUS_POUT_OP_FAULT_LIMIT =3D 0x68,
> > + PMBUS_POUT_OP_FAULT_RESPONSE =3D 0x69,
> > PMBUS_POUT_OP_WARN_LIMIT =3D 0x6A,
> > PMBUS_PIN_OP_WARN_LIMIT =3D 0x6B,
> >
> > + /* 0x6C - 0x77 are reserved */
> > +
> > PMBUS_STATUS_BYTE =3D 0x78,
> > PMBUS_STATUS_WORD =3D 0x79,
> > PMBUS_STATUS_VOUT =3D 0x7A,
> > @@ -94,6 +141,11 @@ enum pmbus_regs {
> > PMBUS_STATUS_FAN_12 =3D 0x81,
> > PMBUS_STATUS_FAN_34 =3D 0x82,
> >
> > + PMBUS_READ_KWH_IN =3D 0x83,
> > + PMBUS_READ_KWH_OUT =3D 0x84,
> > + PMBUS_READ_KWH_CONFIG =3D 0x85,
> > + PMBUS_READ_EIN =3D 0x86,
> > + PMBUS_READ_EOUT =3D 0x87,
> > PMBUS_READ_VIN =3D 0x88,
> > PMBUS_READ_IIN =3D 0x89,
> > PMBUS_READ_VCAP =3D 0x8A,
> > @@ -118,6 +170,7 @@ enum pmbus_regs {
> > PMBUS_MFR_LOCATION =3D 0x9C,
> > PMBUS_MFR_DATE =3D 0x9D,
> > PMBUS_MFR_SERIAL =3D 0x9E,
> > + PMBUS_APP_PROFILE_SUPPORT =3D 0x9F,
> >
> > PMBUS_MFR_VIN_MIN =3D 0xA0,
> > PMBUS_MFR_VIN_MAX =3D 0xA1,
> > @@ -128,13 +181,105 @@ enum pmbus_regs {
> > PMBUS_MFR_IOUT_MAX =3D 0xA6,
> > PMBUS_MFR_POUT_MAX =3D 0xA7,
> >
> > + PMBUS_MFR_TAMBIENT_MAX =3D 0xA8,
> > + PMBUS_MFR_TAMBIENT_MIN =3D 0xA9,
> > + PMBUS_MFR_EFFICIENCY_LL =3D 0xAA,
> > + PMBUS_MFR_EFFICIENCY_HL =3D 0xAB,
> > + PMBUS_MFR_PIN_ACCURACY =3D 0xAC,
> > +
> > PMBUS_IC_DEVICE_ID =3D 0xAD,
> > PMBUS_IC_DEVICE_REV =3D 0xAE,
> >
> > + /* 0xAF is reserved */
> > +
> > + PMBUS_USER_DATA_00 =3D 0xB0,
> > + PMBUS_USER_DATA_01 =3D 0xB1,
> > + PMBUS_USER_DATA_02 =3D 0xB2,
> > + PMBUS_USER_DATA_03 =3D 0xB3,
> > + PMBUS_USER_DATA_04 =3D 0xB4,
> > + PMBUS_USER_DATA_05 =3D 0xB5,
> > + PMBUS_USER_DATA_06 =3D 0xB6,
> > + PMBUS_USER_DATA_07 =3D 0xB7,
> > + PMBUS_USER_DATA_08 =3D 0xB8,
> > + PMBUS_USER_DATA_09 =3D 0xB9,
> > + PMBUS_USER_DATA_10 =3D 0xBA,
> > + PMBUS_USER_DATA_11 =3D 0xBB,
> > + PMBUS_USER_DATA_12 =3D 0xBC,
> > + PMBUS_USER_DATA_13 =3D 0xBD,
> > + PMBUS_USER_DATA_14 =3D 0xBE,
> > + PMBUS_USER_DATA_15 =3D 0xBF,
> > +
> > PMBUS_MFR_MAX_TEMP_1 =3D 0xC0,
> > PMBUS_MFR_MAX_TEMP_2 =3D 0xC1,
> > PMBUS_MFR_MAX_TEMP_3 =3D 0xC2,
> >
> > + /* 0xC3 is reserved /
> > +
> > + PMBUS_MFR_SPECIFIC_C4 =3D 0xC4,
> > + PMBUS_MFR_SPECIFIC_C5 =3D 0xC5,
> > + PMBUS_MFR_SPECIFIC_C6 =3D 0xC6,
> > + PMBUS_MFR_SPECIFIC_C7 =3D 0xC7,
> > + PMBUS_MFR_SPECIFIC_C8 =3D 0xC8,
> > + PMBUS_MFR_SPECIFIC_C9 =3D 0xC9,
> > + PMBUS_MFR_SPECIFIC_CA =3D 0xCA,
> > + PMBUS_MFR_SPECIFIC_CB =3D 0xCB,
> > + PMBUS_MFR_SPECIFIC_CC =3D 0xCC,
> > + PMBUS_MFR_SPECIFIC_CD =3D 0xCD,
> > + PMBUS_MFR_SPECIFIC_CE =3D 0xCE,
> > + PMBUS_MFR_SPECIFIC_CF =3D 0xCF,
> > +
> > + PMBUS_MFR_SPECIFIC_D0 =3D 0xD0,
> > + PMBUS_MFR_SPECIFIC_D1 =3D 0xD1,
> > + PMBUS_MFR_SPECIFIC_D2 =3D 0xD2,
> > + PMBUS_MFR_SPECIFIC_D3 =3D 0xD3,
> > + PMBUS_MFR_SPECIFIC_D4 =3D 0xD4,
> > + PMBUS_MFR_SPECIFIC_D5 =3D 0xD5,
> > + PMBUS_MFR_SPECIFIC_D6 =3D 0xD6,
> > + PMBUS_MFR_SPECIFIC_D7 =3D 0xD7,
> > + PMBUS_MFR_SPECIFIC_D8 =3D 0xD8,
> > + PMBUS_MFR_SPECIFIC_D9 =3D 0xD9,
> > + PMBUS_MFR_SPECIFIC_DA =3D 0xDA,
> > + PMBUS_MFR_SPECIFIC_DB =3D 0xDB,
> > + PMBUS_MFR_SPECIFIC_DC =3D 0xDC,
> > + PMBUS_MFR_SPECIFIC_DD =3D 0xDD,
> > + PMBUS_MFR_SPECIFIC_DE =3D 0xDE,
> > + PMBUS_MFR_SPECIFIC_DF =3D 0xDF,
> > +
> > + PMBUS_MFR_SPECIFIC_E0 =3D 0xE0,
> > + PMBUS_MFR_SPECIFIC_E1 =3D 0xE1,
> > + PMBUS_MFR_SPECIFIC_E2 =3D 0xE2,
> > + PMBUS_MFR_SPECIFIC_E3 =3D 0xE3,
> > + PMBUS_MFR_SPECIFIC_E4 =3D 0xE4,
> > + PMBUS_MFR_SPECIFIC_E5 =3D 0xE5,
> > + PMBUS_MFR_SPECIFIC_E6 =3D 0xE6,
> > + PMBUS_MFR_SPECIFIC_E7 =3D 0xE7,
> > + PMBUS_MFR_SPECIFIC_E8 =3D 0xE8,
> > + PMBUS_MFR_SPECIFIC_E9 =3D 0xE9,
> > + PMBUS_MFR_SPECIFIC_EA =3D 0xEA,
> > + PMBUS_MFR_SPECIFIC_EB =3D 0xEB,
> > + PMBUS_MFR_SPECIFIC_EC =3D 0xEC,
> > + PMBUS_MFR_SPECIFIC_ED =3D 0xED,
> > + PMBUS_MFR_SPECIFIC_EE =3D 0xEE,
> > + PMBUS_MFR_SPECIFIC_EF =3D 0xEF,
> > +
> > + PMBUS_MFR_SPECIFIC_F0 =3D 0xF0,
> > + PMBUS_MFR_SPECIFIC_F1 =3D 0xF1,
> > + PMBUS_MFR_SPECIFIC_F2 =3D 0xF2,
> > + PMBUS_MFR_SPECIFIC_F3 =3D 0xF3,
> > + PMBUS_MFR_SPECIFIC_F4 =3D 0xF4,
> > + PMBUS_MFR_SPECIFIC_F5 =3D 0xF5,
> > + PMBUS_MFR_SPECIFIC_F6 =3D 0xF6,
> > + PMBUS_MFR_SPECIFIC_F7 =3D 0xF7,
> > + PMBUS_MFR_SPECIFIC_F8 =3D 0xF8,
> > + PMBUS_MFR_SPECIFIC_F9 =3D 0xF9,
> > + PMBUS_MFR_SPECIFIC_FA =3D 0xFA,
> > + PMBUS_MFR_SPECIFIC_FB =3D 0xFB,
> > + PMBUS_MFR_SPECIFIC_FC =3D 0xFC,
> > + PMBUS_MFR_SPECIFIC_FD =3D 0xFD,
> > +
> > + PMBUS_MFR_SPECIFIC_COMMAND_EXT =3D 0xFE,
> > + PMBUS_COMMAND_EXT =3D 0xFF,
> > +
> > /
> > * Virtual registers.
> > * Useful to support attributes which are not supported by standard PMBu=
s
> > --
> > 2.25.1
