Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80CA54F656
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381689AbiFQLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381330AbiFQLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096D917AA8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655464059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/axfBUZFW8LEQZFITwqp+B4xGMo7CYHLg2UMQSQxQ4=;
        b=Gg+AObVTZA0rEJ4oWmFvPsvZpf+VZbgxtl0krSFMPoEt8mrWWk2OnAA6Lqv6f6Yzlj5B0K
        XSCSdyljYW+qKx7pg382ogplPpBF/ekaqDuZcPmHFe49OuBQO0ixzyr+hzTIAfasD2sEkQ
        YU1YTEe/mObScBjTzH2f+bp7ZAvlUfg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-QNSfCZ8FOMKORW6qNtHfsw-1; Fri, 17 Jun 2022 07:07:37 -0400
X-MC-Unique: QNSfCZ8FOMKORW6qNtHfsw-1
Received: by mail-ed1-f69.google.com with SMTP id t6-20020a056402524600b0043561dab805so974336edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=a/axfBUZFW8LEQZFITwqp+B4xGMo7CYHLg2UMQSQxQ4=;
        b=MIqjSWZsZysq99fXVDiTrarmXIk782KAhSn52P6BEAl6hX9VRGcJzENNS95UyPGqUx
         DLTTH/tahXQNTAuIHP46Yymir5CO5sq9n4sc8TZzhz3R9/+2XG61q47GD2J78zDnWVb8
         t3/JxFsczh+iwufCyelcFzV46cq5HNw7u1Ye/pvDS73O11w/m8R7y/84iMPSF8lfVvK0
         /jeE3tXMiEqcDygP55YXvNYBbH6URRspIvi9WPG4ZRDEQ4TVkuyWWJnRMtcgsq86oBft
         b6qu5qbdbozAVMsteL+g8G+i9K2ExyNHQ9c6aTf/4EhmSPvkAqoYcC39yDbi6Z0blpIJ
         89Tg==
X-Gm-Message-State: AJIora9Wx1zjUsNGxRbC6V5vewR+j6UJI1/h/bX6ePymwWlU7u6K3e2w
        znXDnglHcYNhAUk1lxE9uhDLrs38Fr0WTJRPibUxj5yV2KmLr29Ca/JxqgzJLTvcmSBeHe+/DPn
        j6LJMhqeNnfRkBI8guncdRqmd
X-Received: by 2002:a17:907:ea7:b0:70f:a27a:dac0 with SMTP id ho39-20020a1709070ea700b0070fa27adac0mr8773364ejc.25.1655464055735;
        Fri, 17 Jun 2022 04:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vL1hgIMBGsZYx4U7gZfPJ5RuPcWuXfrd/igsu+Lia0B9/3XytmzAiMOQedazlZFGL654pAyw==
X-Received: by 2002:a17:907:ea7:b0:70f:a27a:dac0 with SMTP id ho39-20020a1709070ea700b0070fa27adac0mr8773322ejc.25.1655464055379;
        Fri, 17 Jun 2022 04:07:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id p22-20020a056402155600b0042dd4f9c464sm3420727edx.84.2022.06.17.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 04:07:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------48B3PnPOuSW6Xi7mGn4gA4mS"
Message-ID: <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
Date:   Fri, 17 Jun 2022 13:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
Content-Language: en-US
To:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPqSeKu9csK_u0S6MiRay_mvfYejUhKbb=wvJO7F_Z-JL6F7DA@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------48B3PnPOuSW6Xi7mGn4gA4mS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/17/22 09:51, Kenneth Chan wrote:
> On Thu, 16 Jun 2022 at 03:28, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Kenneth, can you check with e.g. evemu-record or evtest
>> where the double events are coming from ?  Obviously one of
>> the events is coming from the panasonic-laptop driver, but
>> where is the other event coming from. Is it coming from the
>> atkbd driver; or ... ?   Maybe from the acpi-video driver
>> for the brightness keys ?
>>
> 
> Here's the evtest results:
> 
> acpi-video driver generates KEY_BRIGHTNESSDOWN, KEY_BRIGHTNESSUP
> atkbd generates KEY_MUTE, KEY_VOLUMEUP, KEY_VOLUMEDOWN
> 
> Hotkey_input=Y (i.e. before patch ed83c9171829)
> panasonic-laptop driver generates all keys, i.e. KEY_SLEEP,
> KEY_BATTERY, KEY_SUSPEND plus all the above keys
> 
> hotkey_input=N
> panasonic-laptop driver generates KEY_SLEEP, KEY_BATTERY and KEY_SUSPEND
> 
> So the duplicated brightness and volume key events come from the atkbd
> and acpi-video drivers on my CF-W5. I haven't looked at the other
> platform drivers. I'm wondering if they honour atkbd and acpi-driver
> events in a case like this, or just report everything.

Thank you for providing this info. Can you please give
the attached patch series a try, this includes Stefan's 1/2 patch
and replaces Stefan's 2/2 patch.

This will hopefully fix the double key-presses for you, while
also keeping everything working for Stefan without requiring
a module option or DMI quirks.

Stefan can you also give this series a try please?

###

Looking at this has also brought up an unrelated backlight question:

Kenneth, since you have acpi-video reporting keypresses you will
likely also have an acpi_video (or perhaps a native intel) backlight
under /sys/class/backlight and I noticed that panasonic-laptop
uncondirionally registers its backlight so you may very well end
up with 2 backlight controls under /sys/class/backlight, which
we generally try to avoid (so that userspace does not have to
guess which one to use).

Can you do:
ls /sys/class/backlight

and let me know the output?

Also if there are 2 backlights there then please do:
cat /sys/class/backlight/<name>/max_brightness
to find out the range (0-value)

and then try if they both work by doing:

echo $number > /sys/class/backlight/<name>/brightness

with different $number values in the range and see
if this actually changes the brightness.

While we are at it, Stefan can you do the same please?

Regards,

Hans






> 
> Attached is the dmidecode of my CF-W5, just to be verbose.
> 
>> Hence the module parameter so that the two known users of this module (Kenneth and me) can adjust this to their needs.
>>
>> Now about the DMI match: I can do that.
>> But let's face it: the panasonic laptops are pretty rare in the wild, so even if I'm "whitelisting" the CF-51, then probably other models will need the same treatment and we have no real way of finding out which ones, unless people complain.
>> So even if I add the DMI match (which is a good idea anyhow because then "my" model will work out of the box, while right now I need to add a module parameter or switch it on later), I'd still vote for having a possibility for overriding the DMI results.
> 
> In an ideal world, more panasonic-laptop users will send us their
> DSDT. I think the most uptodate model has a MAT0035 device_id (it
> increments for each generation) while our driver is at the very
> outdated MAT0021. But before it happens, I agree with Stefan on that
> point.
> 
--------------48B3PnPOuSW6Xi7mGn4gA4mS
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-panasonic-laptop-de-obfuscate-button-co.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-panasonic-laptop-de-obfuscate-button-co.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2NGZjNjQ0Y2E3YzdlODgzMGIwYTg2ZjljZmEzOTA2OWM1OWVlZWNhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gU2V5ZnJpZWQgPHNlaWZlK2tlcm5lbEBi
MS1zeXN0ZW1zLmNvbT4KRGF0ZTogU3VuLCAxMiBKdW4gMjAyMiAxMTowNTowNiArMDIwMApT
dWJqZWN0OiBbUEFUQ0ggMS81XSBwbGF0Zm9ybS94ODY6IHBhbmFzb25pYy1sYXB0b3A6IGRl
LW9iZnVzY2F0ZSBidXR0b24gY29kZXMKCkluIHRoZSBkZWZpbml0aW9uIG9mIHBhbmFzb25p
Y19rZXltYXBbXSB0aGUga2V5IGNvZGVzIGFyZSBnaXZlbiBpbgpkZWNpbWFsLCBsYXRlciBj
aGVja3MgYXJlIGRvbmUgd2l0aCBoZXhhZGVjaW1hbCB2YWx1ZXMsIHdoaWNoIGRvZXMKbm90
IGhlbHAgaW4gdW5kZXJzdGFuZGluZyB0aGUgY29kZS4KQWRkaXRpb25hbGx5IHVzZSB0d28g
aGVscGVyIHZhcmlhYmxlcyB0byBzaG9ydGVuIHRoZSBjb2RlIGFuZCBtYWtlCnRoZSBsb2dp
YyBtb3JlIG9idmlvdXMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gU2V5ZnJpZWQgPHNlaWZl
K2tlcm5lbEBiMS1zeXN0ZW1zLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIyMDYxMjA5MDUwNy4yMDY0OC0yLXN0ZWZhbi5zZXlmcmllZEBnb29nbGVtYWlsLmNv
bQpSZXZpZXdlZC1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KU2ln
bmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBk
cml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMgfCAxNiArKysrKysrKysr
Ky0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9w
LmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMKaW5kZXggMzc4
NTBkMDc5ODdkLi5jYTYxMzdmNDAwMGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L3BhbmFzb25pYy1sYXB0b3AuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5h
c29uaWMtbGFwdG9wLmMKQEAgLTc2Miw2ICs3NjIsOCBAQCBzdGF0aWMgdm9pZCBhY3BpX3Bj
Y19nZW5lcmF0ZV9rZXlpbnB1dChzdHJ1Y3QgcGNjX2FjcGkgKnBjYykKIAlzdHJ1Y3QgaW5w
dXRfZGV2ICpob3RrX2lucHV0X2RldiA9IHBjYy0+aW5wdXRfZGV2OwogCWludCByYzsKIAl1
bnNpZ25lZCBsb25nIGxvbmcgcmVzdWx0OworCXVuc2lnbmVkIGludCBrZXk7CisJdW5zaWdu
ZWQgaW50IHVwZG93bjsKIAogCXJjID0gYWNwaV9ldmFsdWF0ZV9pbnRlZ2VyKHBjYy0+aGFu
ZGxlLCBNRVRIT0RfSEtFWV9RVUVSWSwKIAkJCQkgICBOVUxMLCAmcmVzdWx0KTsKQEAgLTc3
MCwxOCArNzcyLDIyIEBAIHN0YXRpYyB2b2lkIGFjcGlfcGNjX2dlbmVyYXRlX2tleWlucHV0
KHN0cnVjdCBwY2NfYWNwaSAqcGNjKQogCQlyZXR1cm47CiAJfQogCisJa2V5ID0gcmVzdWx0
ICYgMHhmOworCXVwZG93biA9IHJlc3VsdCAmIDB4ODA7IC8qIDB4ODAgPT0ga2V5IGRvd247
IDB4MDAgPSBrZXkgdXAgKi8KKwogCS8qIGhhY2s6IHNvbWUgZmlybXdhcmUgc2VuZHMgbm8g
a2V5IGRvd24gZm9yIHNsZWVwIC8gaGliZXJuYXRlICovCi0JaWYgKChyZXN1bHQgJiAweGYp
ID09IDB4NyB8fCAocmVzdWx0ICYgMHhmKSA9PSAweGEpIHsKLQkJaWYgKHJlc3VsdCAmIDB4
ODApCisJaWYgKGtleSA9PSA3IHx8IGtleSA9PSAxMCkgeworCQlpZiAodXBkb3duKQogCQkJ
c2xlZXBfa2V5ZG93bl9zZWVuID0gMTsKIAkJaWYgKCFzbGVlcF9rZXlkb3duX3NlZW4pCiAJ
CQlzcGFyc2Vfa2V5bWFwX3JlcG9ydF9ldmVudChob3RrX2lucHV0X2RldiwKLQkJCQkJcmVz
dWx0ICYgMHhmLCAweDgwLCBmYWxzZSk7CisJCQkJCWtleSwgMHg4MCwgZmFsc2UpOwogCX0K
IAotCWlmICgocmVzdWx0ICYgMHhmKSA9PSAweDcgfHwgKHJlc3VsdCAmIDB4ZikgPT0gMHg5
IHx8IChyZXN1bHQgJiAweGYpID09IDB4YSkgeworCS8qIGZvciB0aGUgbWFnaWMgdmFsdWVz
LCBzZWUgcGFuYXNvbmljX2tleW1hcFtdIGFib3ZlICovCisJaWYgKGtleSA9PSA3IHx8IGtl
eSA9PSA5IHx8IGtleSA9PSAxMCkgewogCQlpZiAoIXNwYXJzZV9rZXltYXBfcmVwb3J0X2V2
ZW50KGhvdGtfaW5wdXRfZGV2LAotCQkJCQkJcmVzdWx0ICYgMHhmLCByZXN1bHQgJiAweDgw
LCBmYWxzZSkpCisJCQkJCQlrZXksIHVwZG93biwgZmFsc2UpKQogCQkJcHJfZXJyKCJVbmtu
b3duIGhvdGtleSBldmVudDogMHglMDRsbHhcbiIsIHJlc3VsdCk7CiAJfQogfQotLSAKMi4z
Ni4wCgo=
--------------48B3PnPOuSW6Xi7mGn4gA4mS
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-platform-x86-panasonic-laptop-Sort-includes-alphabet.patch"
Content-Disposition: attachment;
 filename*0="0002-platform-x86-panasonic-laptop-Sort-includes-alphabet.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwMjkxNjZmMTM2MzJmNDc3NGVhZmIwOTU5NmZjODdkMmEyOWE3NDI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBGcmksIDE3IEp1biAyMDIyIDEyOjM5OjUxICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAyLzVdIHBsYXRmb3JtL3g4NjogcGFuYXNvbmljLWxhcHRvcDogU29ydCBpbmNsdWRl
cwogYWxwaGFiZXRpY2FsbHkKClNvcnQgaW5jbHVkZXMgYWxwaGFiZXRpY2FsbHksIHNtYWxs
IGNsZWFudXAgcGF0Y2ggaW4gcHJlcGFyYXRpb24gb2YKZnVydGhlciBjaGFuZ2VzLgoKU2ln
bmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBk
cml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMgfCAxNyArKysrKysrKy0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9w
LmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMKaW5kZXggY2E2
MTM3ZjQwMDBmLi4yNmUzMWFjMDlkYzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L3BhbmFzb25pYy1sYXB0b3AuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5h
c29uaWMtbGFwdG9wLmMKQEAgLTExOSwyMCArMTE5LDE5IEBACiAgKgkJLSB2MC4xICBzdGFy
dCBmcm9tIHRvc2hpYmFfYWNwaSBkcml2ZXIgd3JpdHRlbiBieSBKb2huIEJlbG1vbnRlCiAg
Ki8KIAotI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgotI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPgotI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KLSNpbmNsdWRlIDxsaW51eC90eXBlcy5o
PgorI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4KICNpbmNsdWRlIDxsaW51eC9iYWNrbGlnaHQu
aD4KICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPgotI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxl
Lmg+Ci0jaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgotI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4KLSNpbmNsdWRlIDxsaW51eC9hY3BpLmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgog
I2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CiAjaW5jbHVkZSA8bGludXgvaW5wdXQvc3BhcnNl
LWtleW1hcC5oPgorI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgotCisjaW5j
bHVkZSA8bGludXgvc2VxX2ZpbGUuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CisjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAKIE1P
RFVMRV9BVVRIT1IoIkhpcm9zaGkgTWl1cmEgPG1pdXJhQGRhLWNoYS5vcmc+Iik7CiBNT0RV
TEVfQVVUSE9SKCJEYXZpZCBCcm9uYXVnaCA8ZGJyb25hdWdoQGxpbnV4Ym94ZW4ub3JnPiIp
OwotLSAKMi4zNi4wCgo=
--------------48B3PnPOuSW6Xi7mGn4gA4mS
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-platform-x86-panasonic-laptop-revert-Resolve-hotkey-.patch"
Content-Disposition: attachment;
 filename*0="0003-platform-x86-panasonic-laptop-revert-Resolve-hotkey-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkYzdlMmU3MTg4NzE3MTVlMzM1OWFmOWUzYjZlNzk0YjgzYzRiMzgzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBGcmksIDE3IEp1biAyMDIyIDExOjM2OjQzICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAzLzVdIHBsYXRmb3JtL3g4NjogcGFuYXNvbmljLWxhcHRvcDogcmV2ZXJ0ICJSZXNv
bHZlIGhvdGtleQogZG91YmxlIHRyaWdnZXIgYnVnIgoKSW4gaGluZHNpZ2h0IGJsaW5kbHkg
dGhyb3dpbmcgYXdheSBtb3N0IG9mIHRoZSBrZXktcHJlc3MgZXZlbnRzIGlzIG5vdAphIGdv
b2QgaWRlYS4gU28gcmV2ZXJ0IGNvbW1pdCBlZDgzYzkxNzE4MjkgKCJwbGF0Zm9ybS94ODY6
CnBhbmFzb25pYy1sYXB0b3A6IFJlc29sdmUgaG90a2V5IGRvdWJsZSB0cmlnZ2VyIGJ1ZyIp
LgoKRml4ZXM6IGVkODNjOTE3MTgyOSAoInBsYXRmb3JtL3g4NjogcGFuYXNvbmljLWxhcHRv
cDogUmVzb2x2ZSBob3RrZXkgZG91YmxlIHRyaWdnZXIgYnVnIikKUmVwb3J0ZWQtYnk6IFN0
ZWZhbiBTZXlmcmllZCA8c2VpZmUra2VybmVsQGIxLXN5c3RlbXMuY29tPgpTaWduZWQtb2Zm
LWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMv
cGxhdGZvcm0veDg2L3BhbmFzb25pYy1sYXB0b3AuYyB8IDggKystLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvcGFuYXNvbmljLWxhcHRvcC5jIGIvZHJpdmVycy9wbGF0
Zm9ybS94ODYvcGFuYXNvbmljLWxhcHRvcC5jCmluZGV4IDI2ZTMxYWMwOWRjNi4uMmU2NTMx
ZGQxNWY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFw
dG9wLmMKKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvcGFuYXNvbmljLWxhcHRvcC5jCkBA
IC03ODMsMTIgKzc4Myw4IEBAIHN0YXRpYyB2b2lkIGFjcGlfcGNjX2dlbmVyYXRlX2tleWlu
cHV0KHN0cnVjdCBwY2NfYWNwaSAqcGNjKQogCQkJCQlrZXksIDB4ODAsIGZhbHNlKTsKIAl9
CiAKLQkvKiBmb3IgdGhlIG1hZ2ljIHZhbHVlcywgc2VlIHBhbmFzb25pY19rZXltYXBbXSBh
Ym92ZSAqLwotCWlmIChrZXkgPT0gNyB8fCBrZXkgPT0gOSB8fCBrZXkgPT0gMTApIHsKLQkJ
aWYgKCFzcGFyc2Vfa2V5bWFwX3JlcG9ydF9ldmVudChob3RrX2lucHV0X2RldiwKLQkJCQkJ
CWtleSwgdXBkb3duLCBmYWxzZSkpCi0JCQlwcl9lcnIoIlVua25vd24gaG90a2V5IGV2ZW50
OiAweCUwNGxseFxuIiwgcmVzdWx0KTsKLQl9CisJaWYgKCFzcGFyc2Vfa2V5bWFwX3JlcG9y
dF9ldmVudChob3RrX2lucHV0X2Rldiwga2V5LCB1cGRvd24sIGZhbHNlKSkKKwkJcHJfZXJy
KCJVbmtub3duIGhvdGtleSBldmVudDogMHglMDRsbHhcbiIsIHJlc3VsdCk7CiB9CiAKIHN0
YXRpYyB2b2lkIGFjcGlfcGNjX2hvdGtleV9ub3RpZnkoc3RydWN0IGFjcGlfZGV2aWNlICpk
ZXZpY2UsIHUzMiBldmVudCkKLS0gCjIuMzYuMAoK
--------------48B3PnPOuSW6Xi7mGn4gA4mS
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-platform-x86-panasonic-laptop-Don-t-report-duplicate.patch"
Content-Disposition: attachment;
 filename*0="0004-platform-x86-panasonic-laptop-Don-t-report-duplicate.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYmE1OTc5MjBjNWI2NGE2MTYzNTg1MjZiYmNmMmQzODlmOGNlZjljIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBGcmksIDE3IEp1biAyMDIyIDExOjQ5OjU4ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCA0LzVdIHBsYXRmb3JtL3g4NjogcGFuYXNvbmljLWxhcHRvcDogRG9uJ3QgcmVwb3J0
IGR1cGxpY2F0ZQogYnJpZ2h0bmVzcyBrZXktcHJlc3NlcwoKVGhlIGJyaWdodG5lc3Mga2V5
LXByZXNzZXMgbWlnaHQgYWxzbyBnZXQgcmVwb3J0ZWQgYnkgdGhlIEFDUEkgdmlkZW8gYnVz
LApjaGVjayBmb3IgdGhpcyBhbmQgaW4gdGhpcyBjYXNlIGRvbid0IHJlcG9ydCB0aGUgcHJl
c3NlcyB0byBhdm9pZCByZXBvcnRpbmcKMiBwcmVzc2VzIGZvciBhIHNpbmdsZSBrZXktcHJl
c3MuCgpGaXhlczogZWQ4M2M5MTcxODI5ICgicGxhdGZvcm0veDg2OiBwYW5hc29uaWMtbGFw
dG9wOiBSZXNvbHZlIGhvdGtleSBkb3VibGUgdHJpZ2dlciBidWciKQpSZXBvcnRlZC1ieTog
S2VubmV0aCBDaGFuIDxrZW5uZXRoLnQuY2hhbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6
IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0
Zm9ybS94ODYvS2NvbmZpZyAgICAgICAgICAgIHwgMSArCiBkcml2ZXJzL3BsYXRmb3JtL3g4
Ni9wYW5hc29uaWMtbGFwdG9wLmMgfCA4ICsrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L0tjb25m
aWcgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnCmluZGV4IDBhYzc3ZDA1NTNkYS4u
YTZkZTE0YzNhY2ExIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmln
CisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L0tjb25maWcKQEAgLTk0Miw2ICs5NDIsNyBA
QCBjb25maWcgUEFOQVNPTklDX0xBUFRPUAogCXRyaXN0YXRlICJQYW5hc29uaWMgTGFwdG9w
IEV4dHJhcyIKIAlkZXBlbmRzIG9uIElOUFVUICYmIEFDUEkKIAlkZXBlbmRzIG9uIEJBQ0tM
SUdIVF9DTEFTU19ERVZJQ0UKKwlkZXBlbmRzIG9uIEFDUElfVklERU89biB8fCBBQ1BJX1ZJ
REVPCiAJc2VsZWN0IElOUFVUX1NQQVJTRUtNQVAKIAloZWxwCiAJICBUaGlzIGRyaXZlciBh
ZGRzIHN1cHBvcnQgZm9yIGFjY2VzcyB0byBiYWNrbGlnaHQgY29udHJvbCBhbmQgaG90a2V5
cwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvcGFuYXNvbmljLWxhcHRvcC5j
IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvcGFuYXNvbmljLWxhcHRvcC5jCmluZGV4IDJlNjUz
MWRkMTVmOS4uZDY1ZTZjMjM3MmNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9wYW5hc29uaWMtbGFwdG9wLmMKKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvcGFuYXNv
bmljLWxhcHRvcC5jCkBAIC0xMzIsNiArMTMyLDcgQEAKICNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+CiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KICNpbmNsdWRlIDxsaW51eC91YWNjZXNz
Lmg+CisjaW5jbHVkZSA8YWNwaS92aWRlby5oPgogCiBNT0RVTEVfQVVUSE9SKCJIaXJvc2hp
IE1pdXJhIDxtaXVyYUBkYS1jaGEub3JnPiIpOwogTU9EVUxFX0FVVEhPUigiRGF2aWQgQnJv
bmF1Z2ggPGRicm9uYXVnaEBsaW51eGJveGVuLm9yZz4iKTsKQEAgLTc4Myw2ICs3ODQsMTMg
QEAgc3RhdGljIHZvaWQgYWNwaV9wY2NfZ2VuZXJhdGVfa2V5aW5wdXQoc3RydWN0IHBjY19h
Y3BpICpwY2MpCiAJCQkJCWtleSwgMHg4MCwgZmFsc2UpOwogCX0KIAorCS8qCisJICogRG9u
J3QgcmVwb3J0IGJyaWdodG5lc3Mga2V5LXByZXNzZXMgaWYgdGhleSBhcmUgYWxzbyByZXBv
cnRlZAorCSAqIGJ5IHRoZSBBQ1BJIHZpZGVvIGJ1cy4KKwkgKi8KKwlpZiAoKGtleSA9PSAx
IHx8IGtleSA9PSAyKSAmJiBhY3BpX3ZpZGVvX2hhbmRsZXNfYnJpZ2h0bmVzc19rZXlfcHJl
c3NlcygpKQorCQlyZXR1cm47CisKIAlpZiAoIXNwYXJzZV9rZXltYXBfcmVwb3J0X2V2ZW50
KGhvdGtfaW5wdXRfZGV2LCBrZXksIHVwZG93biwgZmFsc2UpKQogCQlwcl9lcnIoIlVua25v
d24gaG90a2V5IGV2ZW50OiAweCUwNGxseFxuIiwgcmVzdWx0KTsKIH0KLS0gCjIuMzYuMAoK

--------------48B3PnPOuSW6Xi7mGn4gA4mS
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-platform-x86-panasonic-laptop-filter-out-duplicate-v.patch"
Content-Disposition: attachment;
 filename*0="0005-platform-x86-panasonic-laptop-filter-out-duplicate-v.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkMDU3Yjc2ZGE4MTkzYzg0MTAyODQxMDBmOWVmYzMyZTAwMDZhZDA5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBGcmksIDE3IEp1biAyMDIyIDEyOjM1OjI0ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCA1LzVdIHBsYXRmb3JtL3g4NjogcGFuYXNvbmljLWxhcHRvcDogZmlsdGVyIG91dCBk
dXBsaWNhdGUKIHZvbHVtZSB1cC9kb3duL211dGUga2V5cHJlc3NlcwoKT24gc29tZSBQYW5h
c29uaWMgbW9kZWxzIHRoZSB2b2x1bWUgdXAvZG93bi9tdXRlIGtleXByZXNzZXMgZ2V0CnJl
cG9ydGVkIGJvdGggdGhyb3VnaCB0aGUgUGFuYXNvbmljIEFDUEkgSEtFWSBpbnRlcmZhY2Ug
YXMgd2VsbCBhcwp0aHJvdWdoIHRoZSBhdGtiZCBkZXZpY2UuCgpGaWx0ZXIgb3V0IHRoZSBh
dGtiZCBzY2FuLWNvZGVzIGZvciB0aGVzZSB0byBhdm9pZCByZXBvcnRpbmcgcHJlc3Nlcwp0
d2ljZS4KCk5vdGUgbm9ybWFsbHkgd2Ugd291bGQgbGVhdmUgdGhlIGZpbHRlcmluZyBvZiB0
aGVzZSB0byB1c2Vyc3BhY2UgYnkgbWFwcGluZwp0aGUgc2Nhbi1jb2RlcyB0byBLRVlfVU5L
Tk9XTiB0aHJvdWdoIC9saWIvdWRldi9od2RiLmQvNjAta2V5Ym9hcmQuaHdkYi4KSG93ZXZl
ciBpbiB0aGlzIGNhc2UgdGhhdCB3b3VsZCBjYXVzZSByZWdyZXNzaW9ucyBzaW5jZSB3ZSB3
ZXJlIGZpbHRlcmluZwp0aGUgUGFuYXNvbmljIEFDUEkgSEtFWSBldmVudHMgYmVmb3JlLCBz
byBmaWx0ZXIgdGhlc2UgaW4gdGhlIGtlcm5lbC4KCkZpeGVzOiBlZDgzYzkxNzE4MjkgKCJw
bGF0Zm9ybS94ODY6IHBhbmFzb25pYy1sYXB0b3A6IFJlc29sdmUgaG90a2V5IGRvdWJsZSB0
cmlnZ2VyIGJ1ZyIpClJlcG9ydGVkLWJ5OiBLZW5uZXRoIENoYW4gPGtlbm5ldGgudC5jaGFu
QGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVk
aGF0LmNvbT4KLS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnICAgICAgICAgICAg
fCAgMSArCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMgfCA0MSAr
KysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnIGIvZHJp
dmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZwppbmRleCBhNmRlMTRjM2FjYTEuLjBmNzIzYzM0
YTYzNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZworKysgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnCkBAIC05NDMsNiArOTQzLDcgQEAgY29uZmln
IFBBTkFTT05JQ19MQVBUT1AKIAlkZXBlbmRzIG9uIElOUFVUICYmIEFDUEkKIAlkZXBlbmRz
IG9uIEJBQ0tMSUdIVF9DTEFTU19ERVZJQ0UKIAlkZXBlbmRzIG9uIEFDUElfVklERU89biB8
fCBBQ1BJX1ZJREVPCisJZGVwZW5kcyBvbiBTRVJJT19JODA0MiB8fCBTRVJJT19JODA0MiA9
IG4KIAlzZWxlY3QgSU5QVVRfU1BBUlNFS01BUAogCWhlbHAKIAkgIFRoaXMgZHJpdmVyIGFk
ZHMgc3VwcG9ydCBmb3IgYWNjZXNzIHRvIGJhY2tsaWdodCBjb250cm9sIGFuZCBob3RrZXlz
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29uaWMtbGFwdG9wLmMKaW5kZXggZDY1ZTZj
MjM3MmNhLi5hNGM4MmIzYTgxY2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L3BhbmFzb25pYy1sYXB0b3AuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wYW5hc29u
aWMtbGFwdG9wLmMKQEAgLTEyMiw2ICsxMjIsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2FjcGku
aD4KICNpbmNsdWRlIDxsaW51eC9iYWNrbGlnaHQuaD4KICNpbmNsdWRlIDxsaW51eC9jdHlw
ZS5oPgorI2luY2x1ZGUgPGxpbnV4L2k4MDQyLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5o
PgogI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CiAjaW5jbHVkZSA8bGludXgvaW5wdXQvc3Bh
cnNlLWtleW1hcC5oPgpAQCAtMTI5LDYgKzEzMCw3IEBACiAjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CiAjaW5jbHVkZSA8
bGludXgvc2VxX2ZpbGUuaD4KKyNpbmNsdWRlIDxsaW51eC9zZXJpby5oPgogI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogI2luY2x1ZGUgPGxp
bnV4L3VhY2Nlc3MuaD4KQEAgLTI0MSw2ICsyNDMsNDIgQEAgc3RydWN0IHBjY19hY3BpIHsK
IAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlCSpwbGF0Zm9ybTsKIH07CiAKKy8qCisgKiBPbiBz
b21lIFBhbmFzb25pYyBtb2RlbHMgdGhlIHZvbHVtZSB1cCAvIGRvd24gLyBtdXRlIGtleXMg
c2VuZCBkdXBsaWNhdGUKKyAqIGtleXByZXNzIGV2ZW50cyBvdmVyIHRoZSBQUy8yIGtiZCBp
bnRlcmZhY2UsIGZpbHRlciB0aGVzZSBvdXQuCisgKi8KK3N0YXRpYyBib29sIHBhbmFzb25p
Y19pODA0Ml9maWx0ZXIodW5zaWduZWQgY2hhciBkYXRhLCB1bnNpZ25lZCBjaGFyIHN0ciwK
KwkJCQkgICBzdHJ1Y3Qgc2VyaW8gKnBvcnQpCit7CisJc3RhdGljIGJvb2wgZXh0ZW5kZWQ7
CisKKwlpZiAoc3RyICYgSTgwNDJfU1RSX0FVWERBVEEpCisJCXJldHVybiBmYWxzZTsKKwor
CWlmIChkYXRhID09IDB4ZTApIHsKKwkJZXh0ZW5kZWQgPSB0cnVlOworCQlyZXR1cm4gdHJ1
ZTsKKwl9IGVsc2UgaWYgKGV4dGVuZGVkKSB7CisJCWV4dGVuZGVkID0gZmFsc2U7CisKKwkJ
c3dpdGNoIChkYXRhICYgMHg3ZikgeworCQljYXNlIDB4MjE6IC8qIGUwIDIxIC8gZTAgYTEs
IFZvbHVtZSBEb3duIHByZXNzIC8gcmVsZWFzZSAqLworCQljYXNlIDB4MjM6IC8qIGUwIDIz
IC8gZTAgYTMsIFZvbHVtZSBNdXRlIHByZXNzIC8gcmVsZWFzZSAqLworCQljYXNlIDB4MzI6
IC8qIGUwIDMyIC8gZTAgYjIsIFZvbHVtZSBVcCBwcmVzcyAvIHJlbGVhc2UgKi8KKwkJCXJl
dHVybiB0cnVlOworCQlkZWZhdWx0OgorCQkJLyoKKwkJCSAqIFJlcG9ydCB0aGUgcHJldmlv
dXNseSBmaWx0ZXJlZCBlMCBiZWZvcmUgY29udGludWluZworCQkJICogd2l0aCB0aGUgbmV4
dCBub24tZmlsdGVyZWQgYnl0ZS4KKwkJCSAqLworCQkJc2VyaW9faW50ZXJydXB0KHBvcnQs
IDB4ZTAsIDApOworCQkJcmV0dXJuIGZhbHNlOworCQl9CisJfQorCisJcmV0dXJuIGZhbHNl
OworfQorCiAvKiBtZXRob2QgYWNjZXNzIGZ1bmN0aW9ucyAqLwogc3RhdGljIGludCBhY3Bp
X3BjY193cml0ZV9zc2V0KHN0cnVjdCBwY2NfYWNwaSAqcGNjLCBpbnQgZnVuYywgaW50IHZh
bCkKIHsKQEAgLTEwMDYsNiArMTA0NCw3IEBAIHN0YXRpYyBpbnQgYWNwaV9wY2NfaG90a2V5
X2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkKIAkJcGNjLT5wbGF0Zm9ybSA9IE5V
TEw7CiAJfQogCisJaTgwNDJfaW5zdGFsbF9maWx0ZXIocGFuYXNvbmljX2k4MDQyX2ZpbHRl
cik7CiAJcmV0dXJuIDA7CiAKIG91dF9wbGF0Zm9ybToKQEAgLTEwMjksNiArMTA2OCw4IEBA
IHN0YXRpYyBpbnQgYWNwaV9wY2NfaG90a2V5X3JlbW92ZShzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KmRldmljZSkKIAlpZiAoIWRldmljZSB8fCAhcGNjKQogCQlyZXR1cm4gLUVJTlZBTDsKIAor
CWk4MDQyX3JlbW92ZV9maWx0ZXIocGFuYXNvbmljX2k4MDQyX2ZpbHRlcik7CisKIAlpZiAo
cGNjLT5wbGF0Zm9ybSkgewogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBjYy0+cGxhdGZvcm0t
PmRldiwgJmRldl9hdHRyX2NkcG93ZXIpOwogCQlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3Rl
cihwY2MtPnBsYXRmb3JtKTsKLS0gCjIuMzYuMAoK

--------------48B3PnPOuSW6Xi7mGn4gA4mS--

