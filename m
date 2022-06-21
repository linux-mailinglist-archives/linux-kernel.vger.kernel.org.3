Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42AA552E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348759AbiFUJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348732AbiFUJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54D7A2459B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655803622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVXKD1SRWCTG8TkMbZT/7AXadnxCyJ3SQLpn/ow4PdQ=;
        b=I+VYX3MV4w+3bOjzV9e5HGkV0wDeSYirmqAvqbqpu5cSoehN7mvx6Cxp2m5k1TfYclF5Bz
        O4sly9KwxOMKubtxyteoSaxXXgWi2goXtk/G6HUDIc+hSU9iVsHNxMSVkDbBdFVUDgVeTy
        /CaWaUsRde0YFbgFmakUgzFEA1ibqI4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155--WwkH5iaMZW9paTTQPM5Yw-1; Tue, 21 Jun 2022 05:26:54 -0400
X-MC-Unique: -WwkH5iaMZW9paTTQPM5Yw-1
Received: by mail-ed1-f69.google.com with SMTP id z20-20020a05640235d400b0042dfc1c0e80so10493035edc.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=yVXKD1SRWCTG8TkMbZT/7AXadnxCyJ3SQLpn/ow4PdQ=;
        b=6rzMXDXZfyzBCNiX3ugzO+2gV/9hjnbSUTraFEyqFl948e9OUm/TPTTtru/4DKUgHe
         6xr5F2REb7ArHbkJ+Z3bUcaAg++zWKc9ZwexpD6+Nuv4D8MDRKdKsiLnOuO/1Au8eOms
         /ZQY7c9PADot91xz/1rwWpspihG+coDC6X3L1YZyAkx3PSDCBJ2cXo9lF8V++jdLIyBi
         FMof76UUX5UJEQqGBuMmhGUcF8mP+hMx6oNDIxgD2/c8TQGgwz9vj7quUEzS3ouAuKCQ
         rvAxhZHVEvT6fYADWGnqrSDoyHYYK69GJl8zlVjrknyeSWT3mG4rmWJcUd6FJs77QG11
         ggiQ==
X-Gm-Message-State: AJIora+/C2U7qq+PHSWFkX0mXv0YoP8u1ycGg8gJ6JPk2jV2OnjAF7aV
        vd2tSsTvs6sOg7ycX01MwBGrUSQO1p8wzhkF6NX9U/Z7OwUAvVGrIBv7X2W3Ed/QuHRYnRHlNag
        tMQxPaMJhrclYrea6HF6fKAJQ
X-Received: by 2002:a17:906:180c:b0:6fe:9a3e:3d5b with SMTP id v12-20020a170906180c00b006fe9a3e3d5bmr24245408eje.202.1655803613048;
        Tue, 21 Jun 2022 02:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSvS7lYna2MDh2044/JxSVtFJKWddti3qUEcXvNYQxtVYoc+q5d0wqxgFitD+YUpLqde3uYA==
X-Received: by 2002:a17:906:180c:b0:6fe:9a3e:3d5b with SMTP id v12-20020a170906180c00b006fe9a3e3d5bmr24245379eje.202.1655803612666;
        Tue, 21 Jun 2022 02:26:52 -0700 (PDT)
Received: from ?IPV6:2001:1c01:2e0c:ab03:79ba:9443:520f:dd0a? (2001-1c01-2e0c-ab03-79ba-9443-520f-dd0a.cable.dynamic.v6.ziggo.nl. [2001:1c01:2e0c:ab03:79ba:9443:520f:dd0a])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b006fe921fcb2dsm7292853ejc.49.2022.06.21.02.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 02:26:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------TvZvkKyiiWksbQIloAfAt1Lu"
Message-ID: <3f3dfbad-9437-2c04-cf56-861649c117fd@redhat.com>
Date:   Tue, 21 Jun 2022 11:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
Content-Language: en-US
To:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com>
 <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
 <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
 <CAPqSeKu9csK_u0S6MiRay_mvfYejUhKbb=wvJO7F_Z-JL6F7DA@mail.gmail.com>
 <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
 <89398c05-92c6-120d-ed51-ab62f1f404eb@message-id.googlemail.com>
 <19e590f1-e865-ad19-e9e4-df1f9274663c@redhat.com>
 <ad0e83af-b704-53b8-3963-b4dd53853f2b@message-id.googlemail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ad0e83af-b704-53b8-3963-b4dd53853f2b@message-id.googlemail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------TvZvkKyiiWksbQIloAfAt1Lu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/20/22 20:10, Stefan Seyfried wrote:
> Hi Hans,
> 
> On 20.06.22 17:08, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for the quick testing.
>>
>> On 6/17/22 15:07, Stefan Seyfried wrote:
>>> Hi Hans,
>>>
>>> On 17.06.22 13:07, Hans de Goede wrote:
>>>
>>>> Thank you for providing this info. Can you please give
>>>> the attached patch series a try, this includes Stefan's 1/2 patch
>>>> and replaces Stefan's 2/2 patch.
>>>>
>>>> This will hopefully fix the double key-presses for you, while
>>>> also keeping everything working for Stefan without requiring
>>>> a module option or DMI quirks.
>>>>
>>>> Stefan can you also give this series a try please?
>>>
>>> Works for me, almost out of the box.
>>> I need to enable "report_key_events=1" in the video module, then the panasonic-acpi module starts reporting brightness up/down keys.
>>
>> Ok, so you need another module option that is not really helpful.
> 
> Well, I looked into the acpi_video.c module and that one is to blame.
> By default, it assumes that both "OUTPUT_KEY_EVENTS" and "BRIGHTNESS_KEY_EVENTS" should be handled by this module.
> But on the CF-51, this does not happen. "Video Bus" does not generate any key events (I'm not sure about output, but plugging in a VGA monitor and enabling/disabling it with xrandr or tapping the "display" fn-f3 hotkey does not get anything from "Video Bus" input device.
> 
>> The idea behind the acpi_video_handles_brightness_key_presses() check
>> is that if the ACPI video bus device is present it is expected to
>> already report brightness up/down keypresses and we want to avoid
>> duplicates.
> 
> Yes, but the check apparently returns true in my case, because:
> 
>         return have_video_busses &&
>                (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);
> 
> apparently i have a video_bus ;-) and report_key_events (== -1) & 2 is true.
> 
> This check is totally fine, it's just that *the acpi_video.c* code is missing a DMI match for my machine telling it that it handles nothing at all.
> 
>> Can you check with evtest or evemu-record that the brightness
>> events are not already being delivered by the "Video Bus"
>> input device ?
> 
> I did, nothing at all gets delivered by Video Bus.
> 
>>> Volume and mute keys work without manual changes.
>>
>> Good.
>>  
>>> (I tested against 5.18.2 because that's what was already prepared. That old machine takes quite some time, even to just compile the platform/x86 subdirectory ;-) but I don't think this is relevant. If you think it is, I can also test against latest 5.19-rc code)
>>
>> Testing against 5.18 is fine .
>>
>>>> Looking at this has also brought up an unrelated backlight question:
>>>>
>>>> Kenneth, since you have acpi-video reporting keypresses you will
>>>> likely also have an acpi_video (or perhaps a native intel) backlight
>>>> under /sys/class/backlight and I noticed that panasonic-laptop
>>>> uncondirionally registers its backlight so you may very well end
>>>> up with 2 backlight controls under /sys/class/backlight, which
>>>> we generally try to avoid (so that userspace does not have to
>>>> guess which one to use).
>>>>
>>>> Can you do:
>>>> ls /sys/class/backlight
>>>
>>> toughbook:~ # ls -l /sys/class/backlight/
>>> total 0
>>> lrwxrwxrwx 1 root root 0 Jun 17 14:45 intel_backlight -> ../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight
>>> lrwxrwxrwx 1 root root 0 Jun 17 14:49 panasonic -> ../../devices/virtual/backlight/panasonic
>>>
>>>> and let me know the output?
>>>>
>>>> Also if there are 2 backlights there then please do:
>>>> cat /sys/class/backlight/<name>/max_brightness
>>>> to find out the range (0-value)
>>>
>>> toughbook:/sys/class/backlight # grep . */max_brightness
>>> intel_backlight/max_brightness:19531
>>> panasonic/max_brightness:255
>>>
>>>> and then try if they both work by doing:
>>>>
>>>> echo $number > /sys/class/backlight/<name>/brightness
>>>>
>>>> with different $number values in the range and see
>>>> if this actually changes the brightness.
>>>
>>> intel_backlight: does not work
>>> panasonic: does work
>>
>> Ok, so that suggests that the ACPI video bus on your
>> device is defunct, so I guess it also does not report
>> key-presses (see above) ?
> 
> Yes, it looks like ACPI video driver is totally useless on that machine.
> 
>> This will also need some work then because we want to move
>> to there only being 1 (actually working) backlight-class
>> device. Rather then having multiple and let userspace
>> guess which one it needs to use.
> 
> Well, the non-working backlight is coming from the i915 driver, but as this is a very old Chipset (i855 GM) I'd rather be happy it works at all instead of complaining ;-)
> (I have another machine of similar age, hp nc6000 with ati graphics, and there is no way getting it to work somewhat reliably at all)

Ah right, you've got a panasonic + a native intel backlight device.

We are going to need a quirk to (eventually also depending on other changes)
disable the broken intel backlight device.

But that won't fix the keys issue, at least not without an extra
quirk just for that.

I wonder if your machine supports the backlight control part of
the ACPI video bus at all. If not that would explain why it is
not reporting brightness keys and that would also give us a way
to solve this without an extra quirk.

And that would actually also avoid the need for a backlight
quirk too.

Can you pass "acpi_backlight=video" on the kernel commandline
and see if a /sys/class/backlight/acpi_video0 device then
shows up. If it does _not_ show up then indeed there is no
ACPI backlight control at all.

In that case please give the attached patches a try on top
of my last series.

The acpi_video patch should fix your brightness keys then and
the extra panasonic-laptop patch should not make any difference
for the available /sys/class/backlight devices on your laptop,
while filtering out the broken panasonic backlight on Kenneth's
device.

Regards,

Hans



> 
>>>> While we are at it, Stefan can you do the same please?
>>>
>>> See above.
>>> But hey, this is an i855GM graphics chip, I'm happy if it is still working *at all* (for example I need to avoid the xf86-intel driver and use the modesetting driver instead to get a usable sytstem)
>>>
>>> And I'm totally happy if all I have to do in the future is a
>>>
>>> option video report_key_events=1
>>>
>>> modprobe.conf file ;-)
>>
>> We really don't want people to have to specify module-options just
>> to have things working.
> 
> I understand, but then it's my job to get that DMI match to set this parameter into acpi_video.c ;-)
> 
>> Stefam, at least for the backlight class-device issue we will need a DMI
>> quirk, so can you run:
>>
>> sudo dmidecode > dmidecode.txt
>>
>> and then attach the output to your next email, or send me a copy
>> privately ?
> 
> I'll send it privately as it is pretty big, but I think
> 
> DMI_BOARD_VENDOR, "Matsushita Electric Industrial Co.,Ltd."
> DMI_BOARD_NAME, "CF51-1L"
> 
> (Similar to the CF51-2L in acpi/sleep.c) will do.
> 
> Best regards,
> 
>     Stefan
--------------TvZvkKyiiWksbQIloAfAt1Lu
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-panasonic-laptop-Use-acpi_video_get_bac.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-panasonic-laptop-Use-acpi_video_get_bac.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmOWFmZDY1NTY0ZTFmNGU4ZTQxYjBjZGJjNzU0YjExZmMwZTJlZGY2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUdWUsIDIxIEp1biAyMDIyIDExOjIwOjQyICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIHBsYXRmb3JtL3g4NjogcGFuYXNvbmljLWxhcHRvcDogVXNlCiBhY3BpX3Zp
ZGVvX2dldF9iYWNrbGlnaHRfdHlwZSgpCgpVc2UgYWNwaV92aWRlb19nZXRfYmFja2xpZ2h0
X3R5cGUoKSB0byBkZXRlcm1pbmUgaWYgd2Ugc2hvdWxkIHJlZ2lzdGVyCnRoZSBwYW5hc29u
aWMgc3BlY2lmaWMgYmFja2xpZ2h0IGludGVyZmFjZS4gVG8gYXZvaWQgcmVnaXN0ZXJpbmcg
dGhpcwpvbiBzeXN0ZW1zIHdoZXJlIHRoZSBBQ1BJIG9yIEdQVSBuYXRpdmUgYmFja2xpZ2h0
IGNvbnRyb2wgbWV0aG9kcwpzaG91bGQgYmUgdXNlZCBpbnN0ZWFkLgoKU2lnbmVkLW9mZi1i
eTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3Bs
YXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMgfCAyMiArKysrKysrKysrKysrLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMKaW5kZXggYTRjODJi
M2E4MWNmLi4wZmE3Njk1MDg5ZTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L3BhbmFzb25pYy1sYXB0b3AuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29u
aWMtbGFwdG9wLmMKQEAgLTk5OCwxNSArOTk4LDE5IEBAIHN0YXRpYyBpbnQgYWNwaV9wY2Nf
aG90a2V5X2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkKIAkJcHJfZXJyKCJDb3Vs
ZG4ndCByZXRyaWV2ZSBCSU9TIGRhdGFcbiIpOwogCQlnb3RvIG91dF9pbnB1dDsKIAl9Ci0J
LyogaW5pdGlhbGl6ZSBiYWNrbGlnaHQgKi8KLQltZW1zZXQoJnByb3BzLCAwLCBzaXplb2Yo
c3RydWN0IGJhY2tsaWdodF9wcm9wZXJ0aWVzKSk7Ci0JcHJvcHMudHlwZSA9IEJBQ0tMSUdI
VF9QTEFURk9STTsKLQlwcm9wcy5tYXhfYnJpZ2h0bmVzcyA9IHBjYy0+c2luZltTSU5GX0FD
X01BWF9CUklHSFRdOwotCXBjYy0+YmFja2xpZ2h0ID0gYmFja2xpZ2h0X2RldmljZV9yZWdp
c3RlcigicGFuYXNvbmljIiwgTlVMTCwgcGNjLAotCQkJCQkJICAgJnBjY19iYWNrbGlnaHRf
b3BzLCAmcHJvcHMpOwotCWlmIChJU19FUlIocGNjLT5iYWNrbGlnaHQpKSB7Ci0JCXJlc3Vs
dCA9IFBUUl9FUlIocGNjLT5iYWNrbGlnaHQpOwotCQlnb3RvIG91dF9pbnB1dDsKKworCWlm
IChhY3BpX3ZpZGVvX2dldF9iYWNrbGlnaHRfdHlwZSgpID09IGFjcGlfYmFja2xpZ2h0X3Zl
bmRvcikgeworCQkvKiBpbml0aWFsaXplIGJhY2tsaWdodCAqLworCQltZW1zZXQoJnByb3Bz
LCAwLCBzaXplb2Yoc3RydWN0IGJhY2tsaWdodF9wcm9wZXJ0aWVzKSk7CisJCXByb3BzLnR5
cGUgPSBCQUNLTElHSFRfUExBVEZPUk07CisJCXByb3BzLm1heF9icmlnaHRuZXNzID0gcGNj
LT5zaW5mW1NJTkZfQUNfTUFYX0JSSUdIVF07CisJCQorCQlwY2MtPmJhY2tsaWdodCA9IGJh
Y2tsaWdodF9kZXZpY2VfcmVnaXN0ZXIoInBhbmFzb25pYyIsIE5VTEwsIHBjYywKKwkJCQkJ
CQkgICAmcGNjX2JhY2tsaWdodF9vcHMsICZwcm9wcyk7CisJCWlmIChJU19FUlIocGNjLT5i
YWNrbGlnaHQpKSB7CisJCQlyZXN1bHQgPSBQVFJfRVJSKHBjYy0+YmFja2xpZ2h0KTsKKwkJ
CWdvdG8gb3V0X2lucHV0OworCQl9CiAJfQogCiAJLyogcmVhZCB0aGUgaW5pdGlhbCBicmln
aHRuZXNzIHNldHRpbmcgZnJvbSB0aGUgaGFyZHdhcmUgKi8KLS0gCjIuMzYuMAoK
--------------TvZvkKyiiWksbQIloAfAt1Lu
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-ACPI-video-Change-how-we-determine-if-brightness-key.patch"
Content-Disposition: attachment;
 filename*0="0002-ACPI-video-Change-how-we-determine-if-brightness-key.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3MGQwN2U5MTU3YmIyODEzNzI2OTg2ZDA2OGZiMGM5OWUxYTYxOWQ5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUdWUsIDIxIEp1biAyMDIyIDExOjEyOjUxICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIEFDUEk6IHZpZGVvOiBDaGFuZ2UgaG93IHdlIGRldGVybWluZSBpZiBicmln
aHRuZXNzCiBrZXktcHJlc3NlcyBhcmUgaGFuZGxlZAoKU29tZSBzeXN0ZW1zIGhhdmUgYW4g
QUNQSSB2aWRlbyBidXMgYnV0IG5vdCBBQ1BJIHZpZGVvIGRldmljZXMgd2l0aApiYWNrbGln
aHQgY2FwYWJpbGl0eS4gT24gdGhlc2UgZGV2aWNlcyBicmlnaHRuZXNzIGtleS1wcmVzc2Vz
IGFyZQoobG9naWNhbGx5KSBub3QgcmVwb3J0ZWQgdGhyb3VnaCB0aGUgQUNQSSB2aWRlbyBi
dXMuCgpDaGFuZ2UgaG93IGFjcGlfdmlkZW9faGFuZGxlc19icmlnaHRuZXNzX2tleV9wcmVz
c2VzKCkgZGV0ZXJtaW5lcyBpZgpicmlnaHRuZXNzIGtleS1wcmVzc2VzIGFyZSBoYW5kbGVk
IGJ5IHRoZSBBQ1BJIHZpZGVvIGRyaXZlciB0byBhdm9pZAp2ZW5kb3Igc3BlY2lmaWMgZHJp
dmVycy9wbGF0Zm9ybS94ODYgZHJpdmVycyBmaWx0ZXJpbmcgb3V0IHRoZWlyCmJyaWdodG5l
c3Mga2V5LXByZXNzZXMgZXZlbiB0aG91Z2ggdGhleSBhcmUgdGhlIG9ubHkgb25lcyByZXBv
cnRpbmcKdGhlc2UgcHJlc3Nlcy4KClJlcG9ydGVkLWJ5OiBTdGVmYW4gU2V5ZnJpZWQgPHNl
aWZlK2tlcm5lbEBiMS1zeXN0ZW1zLmNvbT4KU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2Vk
ZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2FjcGkvYWNwaV92aWRlby5j
IHwgMTMgKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaV92aWRlby5j
IGIvZHJpdmVycy9hY3BpL2FjcGlfdmlkZW8uYwppbmRleCAwMWMzZjYyMjk1YzMuLmJlN2Y0
ZDE5MTJkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL2FjcGlfdmlkZW8uYworKysgYi9k
cml2ZXJzL2FjcGkvYWNwaV92aWRlby5jCkBAIC03OSw2ICs3OSw3IEBAIG1vZHVsZV9wYXJh
bShkZXZpY2VfaWRfc2NoZW1lLCBib29sLCAwNDQ0KTsKIHN0YXRpYyBpbnQgb25seV9sY2Qg
PSAtMTsKIG1vZHVsZV9wYXJhbShvbmx5X2xjZCwgaW50LCAwNDQ0KTsKIAorc3RhdGljIGJv
b2wgaGFzX2JhY2tsaWdodDsKIHN0YXRpYyBpbnQgcmVnaXN0ZXJfY291bnQ7CiBzdGF0aWMg
REVGSU5FX01VVEVYKHJlZ2lzdGVyX2NvdW50X211dGV4KTsKIHN0YXRpYyBERUZJTkVfTVVU
RVgodmlkZW9fbGlzdF9sb2NrKTsKQEAgLTEyMzAsNiArMTIzMSw5IEBAIGFjcGlfdmlkZW9f
YnVzX2dldF9vbmVfZGV2aWNlKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLAogCWFjcGlf
dmlkZW9fZGV2aWNlX2JpbmQodmlkZW8sIGRhdGEpOwogCWFjcGlfdmlkZW9fZGV2aWNlX2Zp
bmRfY2FwKGRhdGEpOwogCisJaWYgKGRhdGEtPmNhcC5fQkNNICYmIGRhdGEtPmNhcC5fQkNM
KQorCQloYXNfYmFja2xpZ2h0ID0gdHJ1ZTsKKwogCW11dGV4X2xvY2soJnZpZGVvLT5kZXZp
Y2VfbGlzdF9sb2NrKTsKIAlsaXN0X2FkZF90YWlsKCZkYXRhLT5lbnRyeSwgJnZpZGVvLT52
aWRlb19kZXZpY2VfbGlzdCk7CiAJbXV0ZXhfdW5sb2NrKCZ2aWRlby0+ZGV2aWNlX2xpc3Rf
bG9jayk7CkBAIC0yMjc2LDYgKzIyODAsNyBAQCB2b2lkIGFjcGlfdmlkZW9fdW5yZWdpc3Rl
cih2b2lkKQogCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnZpZGVvX2J1c19yZWdpc3Rl
cl9iYWNrbGlnaHRfd29yayk7CiAJCWFjcGlfYnVzX3VucmVnaXN0ZXJfZHJpdmVyKCZhY3Bp
X3ZpZGVvX2J1cyk7CiAJCXJlZ2lzdGVyX2NvdW50ID0gMDsKKwkJaGFzX2JhY2tsaWdodCA9
IGZhbHNlOwogCX0KIAltdXRleF91bmxvY2soJnJlZ2lzdGVyX2NvdW50X211dGV4KTsKIH0K
QEAgLTIyOTQsMTMgKzIyOTksNyBAQCBFWFBPUlRfU1lNQk9MKGFjcGlfdmlkZW9fcmVnaXN0
ZXJfYmFja2xpZ2h0KTsKIAogYm9vbCBhY3BpX3ZpZGVvX2hhbmRsZXNfYnJpZ2h0bmVzc19r
ZXlfcHJlc3Nlcyh2b2lkKQogewotCWJvb2wgaGF2ZV92aWRlb19idXNzZXM7Ci0KLQltdXRl
eF9sb2NrKCZ2aWRlb19saXN0X2xvY2spOwotCWhhdmVfdmlkZW9fYnVzc2VzID0gIWxpc3Rf
ZW1wdHkoJnZpZGVvX2J1c19oZWFkKTsKLQltdXRleF91bmxvY2soJnZpZGVvX2xpc3RfbG9j
ayk7Ci0KLQlyZXR1cm4gaGF2ZV92aWRlb19idXNzZXMgJiYKKwlyZXR1cm4gaGFzX2JhY2ts
aWdodCAmJgogCSAgICAgICAocmVwb3J0X2tleV9ldmVudHMgJiBSRVBPUlRfQlJJR0hUTkVT
U19LRVlfRVZFTlRTKTsKIH0KIEVYUE9SVF9TWU1CT0woYWNwaV92aWRlb19oYW5kbGVzX2Jy
aWdodG5lc3Nfa2V5X3ByZXNzZXMpOwotLSAKMi4zNi4wCgo=

--------------TvZvkKyiiWksbQIloAfAt1Lu--

