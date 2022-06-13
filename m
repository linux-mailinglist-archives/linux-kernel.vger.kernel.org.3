Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32954A196
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346280AbiFMVgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346144AbiFMVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:36:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7171C3;
        Mon, 13 Jun 2022 14:36:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 20so10892540lfz.8;
        Mon, 13 Jun 2022 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y4KQ3QQGxvSTObAOJVektW1D7yFig3ypCvu9bU90Cv0=;
        b=YvSDEHvk3ZH2Mhra1J5bIt+rPIPye7evoR2H5b26S7CWCuinSNrncCqslxYkLea7rR
         rwKhFEcgU8EeUBJU/x4XbkuKgTkjNEybsfqdvEHj06KgafFhMEwjM+fcOb+uSSDTSZ7g
         h5wnfFK2PLRoMVqeFFuvhqcvrCnUery3vbpZ6spIiuDswXL4z+VG+HBtGeu+hiCEryE5
         MH7eD5Doul1kluhBMlgjhppVgmuuPyeXABYkL3JbIgdMOpkcjKDvFJvVG9HWh+gvg7Vn
         lPjdAbc+L4H8jRto/3eMw+yYu/qWJ2zY9zBBuEpGsslI/XUdbclYSDexPDZAXqdIKLEl
         z8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y4KQ3QQGxvSTObAOJVektW1D7yFig3ypCvu9bU90Cv0=;
        b=RCGelwLNNygwlMMmYE7JFV+WuV5dmu8kjoVg9/pviMfpQABXEwE7FLamyaUzJsjefx
         /qrGbV3BTPImZMNw+64PC8JEpNUMfpH48+jMKyVFXoeuFvz9wwxe576o5DgPfwtycFQK
         yqfQ+hrzZnuzcH9FKHW5CDUPmlto6wTvGg8N7drFD3FY2119eKrw7ogh7p4eYUDrjUjc
         CgqfCh/LD9xC9jznob4ZJXDrplrC0dhTA927j7segaMGhre1+U8Sm+snOXia3rJTMWU6
         gKnZf9RK7HGiHJaz1X6hIJZJZWniSzIi2l9eHsHmSPaiHYRp9Nvzm7WtDS9iSa0mwNXT
         3D1Q==
X-Gm-Message-State: AJIora+uHPB88BewMeRUoQHgRJdM9Jn8jSXiZB7RQL3J7/N2C7MjI2Yb
        esCLEEoyzrAm0z5bYjj8bshNI5r4Z5PVn8HK+JU=
X-Google-Smtp-Source: AGRyM1tHUcOqgf6aR4pfYGBZ7rLNPluzGCcqBQyjtQTnSoh4GParF7FVJjZJPvQgFte8n8CBkoXCtc55+kDVYkc5Zmc=
X-Received: by 2002:a05:6512:e94:b0:478:f6ad:c9d7 with SMTP id
 bi20-20020a0565120e9400b00478f6adc9d7mr1087643lfb.198.1655156189930; Mon, 13
 Jun 2022 14:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191202193628.GI50317@dtor-ws> <20191202230947.ld5ibnczdpkekfcm@pali>
 <20191203173821.4u6uzxeaqnt3gyz3@pali> <20191203191112.GJ50317@dtor-ws>
 <20191205105206.slibwytrcteicx6y@pali> <CANFp7mXyaqoMDBs4m_Dfm9+4U88g9WoJVcV1g_4KM4xzFhiGXQ@mail.gmail.com>
 <20191206091114.kh255jrmerruumnq@pali> <20191206174048.GQ50317@dtor-ws>
 <20191218110224.44vcgdxh3j4bn7rw@pali> <20191218112659.crabhqkbcnxd6fo6@pali> <20200322154734.mquwgzc63nzddiy5@pali>
In-Reply-To: <20200322154734.mquwgzc63nzddiy5@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jun 2022 14:36:18 -0700
Message-ID: <CABBYNZ+E3knrqWpNDKfX9qQOrrh=VLUSQAgUB=kXgK7=jwgQ9w@mail.gmail.com>
Subject: Re: [PATCH] Input: uinput - Add UI_SET_UNIQ ioctl handler
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-input@vger.kernel.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Kirill Smelkov <kirr@nexedi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 22, 2020 at 8:47 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Wednesday 18 December 2019 12:26:59 Pali Roh=C3=A1r wrote:
> > On Wednesday 18 December 2019 12:02:24 Pali Roh=C3=A1r wrote:
> > > On Friday 06 December 2019 09:40:48 Dmitry Torokhov wrote:
> > > > On Fri, Dec 06, 2019 at 10:11:14AM +0100, Pali Roh=C3=A1r wrote:
> > > > > On Thursday 05 December 2019 12:03:05 Abhishek Pandit-Subedi wrot=
e:
> > > > > > On Thu, Dec 5, 2019 at 2:52 AM Pali Roh=C3=A1r <pali.rohar@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > On Tuesday 03 December 2019 11:11:12 Dmitry Torokhov wrote:
> > > > > > > > On Tue, Dec 03, 2019 at 06:38:21PM +0100, Pali Roh=C3=A1r w=
rote:
> > > > > > > > > On Tuesday 03 December 2019 00:09:47 Pali Roh=C3=A1r wrot=
e:
> > > > > > > > >
> > > > > > > > > Hi Dmitry!
> > > > > > > > >
> > > > > > > > > I was looking again at those _IOW defines for ioctl calls=
 and I have
> > > > > > > > > another argument why not specify 'char *' in _IOW:
> > > > > > > > >
> > > > > > > > > All ioctls in _IOW() specify as a third macro argument ty=
pe which is
> > > > > > > > > passed as pointer to the third argument for ioctl() sysca=
ll.
> > > > > > > > >
> > > > > > > > > So e.g.:
> > > > > > > > >
> > > > > > > > >   #define EVIOCSCLOCKID _IOW('E', 0xa0, int)
> > > > > > > > >
> > > > > > > > > is called from userspace as:
> > > > > > > > >
> > > > > > > > >   int val;
> > > > > > > > >   ioctl(fd, EVIOCSCLOCKID, &val);
> > > > > > > > >
> > > > > > > > > Or
> > > > > > > > >
> > > > > > > > >   #define EVIOCSMASK _IOW('E', 0x93, struct input_mask)
> > > > > > > > >
> > > > > > > > > is called as:
> > > > > > > > >
> > > > > > > > >   struct input_mask val;
> > > > > > > > >   ioctl(fd, EVIOCSMASK, &val);
> > > > > > > > >
> > > > > > > > > So basically third argument for _IOW specify size of byte=
 buffer passed
> > > > > > > > > as third argument for ioctl(). In _IOW is not specified p=
ointer to
> > > > > > > > > struct input_mask, but struct input_mask itself.
> > > > > > > > >
> > > > > > > > > And in case you define
> > > > > > > > >
> > > > > > > > >   #define MY_NEW_IOCTL _IOW(UINPUT_IOCTL_BASE, 200, char*=
)
> > > > > > > > >
> > > > > > > > > then you by above usage you should pass data as:
> > > > > > > > >
> > > > > > > > >   char *val =3D "DATA";
> > > > > > > > >   ioctl(fd, MY_NEW_IOCTL, &val);
> > > > > > > > >
> > > > > > > > > Which is not same as just:
> > > > > > > > >
> > > > > > > > >   ioctl(fd, MY_NEW_IOCTL, "DATA");
> > > > > > > > >
> > > > > > > > > As in former case you passed pointer to pointer to data a=
nd in later
> > > > > > > > > case you passed only pointer to data.
> > > > > > > > >
> > > > > > > > > It just mean that UI_SET_PHYS is already defined inconsis=
tently which is
> > > > > > > > > also reason why compat ioctl for it was introduced.
> > > > > > > >
> > > > > > > > Yes, you are right. UI_SET_PHYS is messed up. I guess the q=
uestion is
> > > > > > > > what to do with all of this...
> > > > > > > >
> > > > > > > > Maybe we should define
> > > > > > > >
> > > > > > > > #define UI_SET_PHYS_STR(len)  _IOC(_IOC_WRITE, UINPUT_IOCTL=
_BASE, 111, len)
> > > > > > > > #define UI_SET_UNIQ_STR(len)  _IOC(_IOC_WRITE, UINPUT_IOCTL=
_BASE, 112, len)
> > > > > > >
> > > > > > > I'm not sure if this is ideal. Normally in C strings are nul-=
termined,
> > > > > > > so functions/macros do not take buffer length.
> > > > > > Except strncpy, strndup, snprintf, etc. all expect a buffer len=
gth. At
> > > > >
> > > > > This is something different as for these functions you pass buffe=
r and
> > > > > length of buffer which is used in write mode -- not for read mode=
.
> > > > >
> > > > > > the user to kernel boundary of ioctl, I think we should require=
 size
> > > > > > of the user buffer regardless of the data type.
> > > > > >
> > > > > > > _STR therefore in names looks inconsistent.
> > > > > > The _STR suffix is odd (what to name UI_SET_PHYS_STR then??) bu=
t
> > > > > > requiring the length seems to be common across various ioctls.
> > > > > > * input.h requires a length when requesting the phys and uniq
> > > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/tree/include/uapi/linux/input.h#n138)
> > > > > > * Same with HIDRAW when setting and getting features:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/include/uapi/linux/hidraw.h#n40,
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/samples/hidraw/hid-example.c#n88
> > > > >
> > > > > All these ioctls where is passed length are in opposite direction
> > > > > (_IOC_READ) as our PHYS and UNIQ (_IOC_WRITE).
> > > > >
> > > > > I fully agree that when you need to read something from kernel
> > > > > (_IOC_READ) and then writing it to userspace, you need to specify=
 length
> > > > > of userspace buffer. Exactly same as with userspace functions lik=
e
> > > > > memcpy, snprintf, etc... as you pointed. Otherwise you get buffer
> > > > > overflow as callee does not know length of buffer.
> > > > >
> > > > > But here we we have there quite different problem, we need to wri=
te
> > > > > something to kernel from userspace (_IOC_WRITE) and we are passin=
g
> > > > > nul-term string. So in this case specifying size is not required =
as it
> > > > > is implicitly specified as part of passed string.
> > > >
> > > > With the new IOCTL definitions it does not need to be a NULL-termin=
ated
> > > > string. It can be a buffer of characters with given length, and ker=
nel
> > > > will NULL-terminate as this it what it wants, not what the caller h=
as to
> > > > give.
> > >
> > > Hi Dmitry! I was thinking more about this problem and I will propose
> > > alternative solution, but first with details...
> > >
> > > I think that we should use NULL terminated strings. Or better disallo=
w
> > > NULL byte inside string. Reason: all userspace application expects th=
at
> > > input device name would be NULL terminated which implies that in the
> > > middle of name cannot be NULL byte.
> > >
> > > So this must apply also for new PHYS / UNIQ ioctl API. If we want in =
our
> > > ioctl API to use buffer + size (with upper bound limit for size) inst=
ead
> > > of passing NULL term string (with upper bound limit for string size)
> > > then kernel have to add a leading NULL byte to string, plus check tha=
t
> > > in the buffer there is no NULL byte. I guess this a very little
> > > complicate code, but nothing which is problematic.
> > >
> > > And on the userspace part. Now when userspace want to pass constant
> > > string for device name, it just call
> > >
> > >   ioctl(fd, UI_SET_PHYS, "my name of device");
> > >
> > > After adding a new ioctl with buffer + size API, userspace would have=
 to
> > > call:
> > >
> > >   ioctl(fd, UI_SET_PHYS_STR(strlen("my name of device")), "my name of=
 device");
> > >
> > > which looks strange, so programmers would had to move device name int=
o
> > > new variable:
> > >
> > >   const char *name =3D "my name of device";
> > >   ioctl(fd, UI_SET_PHYS_STR(strlen(name)), name);
> > >
> > > For me the old ioctl API looks easier to use (no need for strlen() or
> > > extra variable), but this is just my preference of usage -- as it is
> > > simpler for me. Maybe you would have different opinion...
> > >
> > > And now question: Why we have uinput_compat_ioctl()? It is there only
> > > because size part of IOCTL number is different on 32bit and 64bit
> > > systems. As we know size part of UI_SET_PHYS is wrong and does not ma=
ke
> > > sense...
> > >
> > > Would not it be better to change size of UI_SET_PHYS to just zero and
> > > then when matching ioctl number just ignore size for this UI_SET_PHYS
> > > ioctl? Same for UI_BEGIN_FF_UPLOAD_COMPAT and UI_END_FF_UPLOAD_COMPAT
> > > added in: https://git.kernel.org/tip/tip/c/7c7da40
> > >
> > > And we would not have to deal with uinput_compat_ioctl() at all.
> >
> > Below is example how change for removing UI_SET_PHYS_COMPAT may look
> > like. As header file is not changed and UI_SET_PHYS accepts any size
> > argument, it therefore accept also 32bit and 64bit integer. So no
> > existing 32bit applications which use UI_SET_PHYS on 64bit kernel would
> > not be broken...
> >
> > Is not this better change then introducing a new UI_SET_PHYS_STR ioctl
> > number? Because introduction of new IOCTL number has one big
> > disadvantage: Userspace applications needs to support fallback to old
> > number as older versions of kernels would be in use for a long time. An=
d
> > because kernel does not have to remove old IOCTL number for backward
> > compatibility there is basically no need for userspace application to
> > user new UI_SET_PHYS_STR IOCTL number...
>
> Hello! I would like to remind this discussion as problem around a new
> UI_SET_UNIQ ioctl is not solved yet and uniq property is really useful
> for e.g. bluetooth (uinput) devices.
>
> Dmitry, when you have a time, could you please look at this discussion
> and decide how to go ahead?

Have we decided not to move further with these changes? I actually
have a bug in BlueZ related to it since right now we are inconsistent
with respect to how we handle uhid vs uinput:

https://github.com/bluez/bluez/issues/352

> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > index fd253781b..b645210d5 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -915,22 +915,6 @@ static long uinput_ioctl_handler(struct file *file=
, unsigned int cmd,
> >               retval =3D uinput_set_bit(arg, propbit, INPUT_PROP_MAX);
> >               goto out;
> >
> > -     case UI_SET_PHYS:
> > -             if (udev->state =3D=3D UIST_CREATED) {
> > -                     retval =3D -EINVAL;
> > -                     goto out;
> > -             }
> > -
> > -             phys =3D strndup_user(p, 1024);
> > -             if (IS_ERR(phys)) {
> > -                     retval =3D PTR_ERR(phys);
> > -                     goto out;
> > -             }
> > -
> > -             kfree(udev->dev->phys);
> > -             udev->dev->phys =3D phys;
> > -             goto out;
> > -
> >       case UI_BEGIN_FF_UPLOAD:
> >               retval =3D uinput_ff_upload_from_user(p, &ff_up);
> >               if (retval)
> > @@ -1023,6 +1007,22 @@ static long uinput_ioctl_handler(struct file *fi=
le, unsigned int cmd,
> >       case UI_ABS_SETUP & ~IOCSIZE_MASK:
> >               retval =3D uinput_abs_setup(udev, p, size);
> >               goto out;
> > +
> > +     case UI_SET_PHYS & ~IOCSIZE_MASK:
> > +             if (udev->state =3D=3D UIST_CREATED) {
> > +                     retval =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +
> > +             phys =3D strndup_user(p, 1024);
> > +             if (IS_ERR(phys)) {
> > +                     retval =3D PTR_ERR(phys);
> > +                     goto out;
> > +             }
> > +
> > +             kfree(udev->dev->phys);
> > +             udev->dev->phys =3D phys;
> > +             goto out;
> >       }
> >
> >       retval =3D -EINVAL;
> > @@ -1042,8 +1042,6 @@ static long uinput_ioctl(struct file *file, unsig=
ned int cmd, unsigned long arg)
> >   * These IOCTLs change their size and thus their numbers between
> >   * 32 and 64 bits.
> >   */
> > -#define UI_SET_PHYS_COMPAT           \
> > -     _IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
> >  #define UI_BEGIN_FF_UPLOAD_COMPAT    \
> >       _IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload_compat)
> >  #define UI_END_FF_UPLOAD_COMPAT              \
> > @@ -1053,9 +1051,6 @@ static long uinput_compat_ioctl(struct file *file=
,
> >                               unsigned int cmd, unsigned long arg)
> >  {
> >       switch (cmd) {
> > -     case UI_SET_PHYS_COMPAT:
> > -             cmd =3D UI_SET_PHYS;
> > -             break;
> >       case UI_BEGIN_FF_UPLOAD_COMPAT:
> >               cmd =3D UI_BEGIN_FF_UPLOAD;
> >               break;
> > diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
> > index c9e677e3a..6bda2a142 100644
> > --- a/include/uapi/linux/uinput.h
> > +++ b/include/uapi/linux/uinput.h
> > @@ -142,6 +142,8 @@ struct uinput_abs_setup {
> >  #define UI_SET_LEDBIT                _IOW(UINPUT_IOCTL_BASE, 105, int)
> >  #define UI_SET_SNDBIT                _IOW(UINPUT_IOCTL_BASE, 106, int)
> >  #define UI_SET_FFBIT         _IOW(UINPUT_IOCTL_BASE, 107, int)
> > +/* Argument is nul-term string and for backward compatibility is there
> > + * specified char*, but size argument (char *) is ignored by this ioct=
l */
> >  #define UI_SET_PHYS          _IOW(UINPUT_IOCTL_BASE, 108, char*)
> >  #define UI_SET_SWBIT         _IOW(UINPUT_IOCTL_BASE, 109, int)
> >  #define UI_SET_PROPBIT               _IOW(UINPUT_IOCTL_BASE, 110, int)
> >
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
