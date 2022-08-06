Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBC58B748
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiHFRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiHFRaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 13:30:21 -0400
X-Greylist: delayed 156990 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 10:30:19 PDT
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A76370
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 10:30:19 -0700 (PDT)
Date:   Sat, 06 Aug 2022 17:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1659807016; x=1660066216;
        bh=vmIAc6IeQ/s610io59ZSvNdz2SA0u99rz7mT5BOM5/8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=MG7gKhgZ6kH4kolU5cTpxe7UUWmOZcQfTZf1x45NVYdqxoxq+I7SE1O8beS1caVqC
         kVT9scIrHdVX1JH0PpjU8drbOPWk2D0oghadiOAiQVYJrnP9vx9mMLXTN7HAkmZMdG
         sfR9VayYokK1+/+R8wx0Ma+XOT2aaPV7eEcXWHA32XqDdEKibbaVhvRjTKCxgjwGZZ
         TFphmxJNV5ITWyyBZEmd3snn2HZys/XISCNT+z1l6ZjwPq7utjuNgL/VUCmFF6jkd/
         7HxNLUYMeJ+EFyGbZ6VBcIu1aaSlINOUTKuu4JIQJ48X2W/PExsWUTXRF8PrtqpEeL
         r5HrSmyI+s5OA==
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH 1/5] asus-wmi: Add basic support for TUF laptop keyboard RGB
Message-ID: <06B-xdz9pdNnj8DeXMMmdUi9Z7NAmQd3mFSHALyKMARSKZmal3FTLvXYKeF7SX_h78ko8RCpbC3t9wUanK6T2nNz1sYVtrSSGEcsfWAxtXY=@protonmail.com>
In-Reply-To: <20220805081909.10962-2-luke@ljones.dev>
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-2-luke@ljones.dev>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. augusztus 5., p=C3=A9ntek 10:19 keltez=C3=A9ssel, Luke D. Jones <luke=
@ljones.dev> =C3=ADrta:

> Adds support for TUF laptop RGB control via the multicolor LED API.
>
> As this is the base essentials for adjusting the RGB, it sets the
> default mode of the keyboard to static. This overwrites the booted
> state of the keyboard.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 89 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>  2 files changed, 92 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 0e7fbed8a50d..33384e3321bb 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -25,6 +25,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> @@ -190,6 +191,11 @@ struct fan_curve_data {
>  =09u8 percents[FAN_CURVE_POINTS];
>  };
>
> +struct keyboard_rgb_led {
> +=09struct led_classdev_mc dev;
> +=09struct mc_subled subled_info[3]; /* r g b */
> +};
> +
>  struct asus_wmi {
>  =09int dsts_id;
>  =09int spec;
> @@ -234,6 +240,9 @@ struct asus_wmi {
>  =09bool dgpu_disable_available;
>  =09bool dgpu_disable;
>
> +=09bool keyboard_rgb_mode_available;

I think this variable could be introduced in the next patch, it is not used=
 in this one.


> +=09struct keyboard_rgb_led keyboard_rgb_mode;
> +
>  =09bool throttle_thermal_policy_available;
>  =09u8 throttle_thermal_policy_mode;
>
> @@ -1028,6 +1037,35 @@ static enum led_brightness lightbar_led_get(struct=
 led_classdev *led_cdev)
>  =09return result & ASUS_WMI_DSTS_LIGHTBAR_MASK;
>  }
>
> +static int tuf_rgb_brightness_set(struct led_classdev *cdev,
> +=09enum led_brightness brightness)
> +{
> +=09u8 r, g, b;
> +=09int err;
> +=09u32 ret;
> +
> +=09struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(cdev);
> +
> +=09led_mc_calc_color_components(mc_cdev, brightness);
> +=09r =3D mc_cdev->subled_info[0].brightness;
> +=09g =3D mc_cdev->subled_info[1].brightness;
> +=09b =3D mc_cdev->subled_info[2].brightness;
> +
> +=09/* Writing out requires some defaults. This will overwrite boot mode =
*/
> +=09err =3D asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DE=
VID_TUF_RGB_MODE,
> +=09=09=091 | 0 | (r << 16) | (g << 24), (b) | 0, &ret);
> +=09if (err) {
> +=09=09pr_err("Unable to set TUF RGB data?\n");
> +=09=09return err;
> +=09}
> +=09return 0;
> +}
> +
> +static enum led_brightness tuf_rgb_brightness_get(struct led_classdev *c=
dev)
> +{
> +=09return cdev->brightness;
> +}

If you can't query the brightness from the hardware, I think you can leave
`led_classdev::brightness_get` to be `NULL`. This callback is only used fro=
m
`led_update_brightness()` as far as I can see.


> +
>  static void asus_wmi_led_exit(struct asus_wmi *asus)
>  {
>  =09led_classdev_unregister(&asus->kbd_led);
> @@ -1105,6 +1143,57 @@ static int asus_wmi_led_init(struct asus_wmi *asus=
)
>  =09=09=09=09=09   &asus->lightbar_led);
>  =09}
>
> +=09if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> +=09=09struct led_classdev_mc *mc_cdev;
> +=09=09struct mc_subled *mc_led_info;
> +=09=09u8 brightness =3D 127;
> +
> +=09=09mc_cdev =3D &asus->keyboard_rgb_mode.dev;
> +
> +=09=09/*
> +=09=09 * asus::kbd_backlight still controls a base 3-level backlight and=
 when
> +=09=09 * it is on 0, the RGB is not visible at all. RGB should be treate=
d as
> +=09=09 * an additional step.
> +=09=09 */
> +=09=09mc_cdev->led_cdev.name =3D "asus::multicolour::kbd_backlight";
> +=09=09mc_cdev->led_cdev.flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT=
_SHUTDOWN;
> +=09=09mc_cdev->led_cdev.brightness_set_blocking =3D tuf_rgb_brightness_s=
et;
> +=09=09mc_cdev->led_cdev.brightness_get =3D tuf_rgb_brightness_get;
> +
> +=09=09/* Let the multicolour LED own the info */
> +=09=09mc_led_info =3D devm_kmalloc_array(
> +=09=09=09&asus->platform_device->dev,
> +=09=09=093,
> +=09=09=09sizeof(*mc_led_info),
> +=09=09=09GFP_KERNEL | __GFP_ZERO);
> +

I am a bit confused as to why dynamic allocation is needed here. Haven't yo=
u
already "allocated" the storage in `keyboard_rgb_led::subled_info`?


> +=09=09if (!mc_led_info)
> +=09=09=09return -ENOMEM;
> +
> +=09=09mc_led_info[0].color_index =3D LED_COLOR_ID_RED;
> +=09=09mc_led_info[1].color_index =3D LED_COLOR_ID_GREEN;
> +=09=09mc_led_info[2].color_index =3D LED_COLOR_ID_BLUE;
> +
> +=09=09/*
> +=09=09 * It's not possible to get last set data from device so set defau=
lts
> +=09=09 * to make it safe for a user to change either RGB or modes. We do=
n't
> +=09=09 * write these defaults to the device because they will overwrite =
a
> +=09=09 * users last saved boot setting (in NVRAM).
> +=09=09 */
> +=09=09mc_cdev->led_cdev.brightness =3D brightness;
> +=09=09mc_cdev->led_cdev.max_brightness =3D brightness;
> +=09=09mc_led_info[0].intensity =3D brightness;
> +=09=09mc_led_info[0].brightness =3D mc_cdev->led_cdev.brightness;
> +=09=09mc_led_info[1].brightness =3D mc_cdev->led_cdev.brightness;
> +=09=09mc_led_info[2].brightness =3D mc_cdev->led_cdev.brightness;
> +=09=09led_mc_calc_color_components(mc_cdev, brightness);
> +
> +=09=09mc_cdev->subled_info =3D mc_led_info;
> +=09=09mc_cdev->num_colors =3D 3;

`led_mc_calc_color_components()` uses `led_classdev_mc::num_colors`, so I t=
hink
it needs to be set before calling it. But that function sets the subled bri=
ghtness
based on the intensity, so it will overwrite the brightness values that hav=
e just
been set.


> +
> +=09=09rv =3D led_classdev_multicolor_register(&asus->platform_device->de=
v, mc_cdev);
> +=09}
> +
>  error:
>  =09if (rv)
>  =09=09asus_wmi_led_exit(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index a571b47ff362..d63c9945a17d 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU=09=090x00090020
>
> +/* TUF laptop RGB control */
> +#define ASUS_WMI_DEVID_TUF_RGB_MODE=090x00100056
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT=090x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT=090x00000002
> --
> 2.37.1
>
>


Regards,
Barnab=C3=A1s P=C5=91cze
