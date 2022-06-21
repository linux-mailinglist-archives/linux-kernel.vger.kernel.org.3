Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB09D552E74
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349007AbiFUJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348890AbiFUJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C23CF25C7E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655804086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWzQF61uANH2HUaxbmeM2TgavDsoShFLMy1+w4turxk=;
        b=f0Bjs5PwVfFxdEPRoD5VsTkl+XqjIn2f2FCOBtWlRYEHW//zcpLvqCKIIBtT7nDqiE5JE5
        f0rA+nNTMgduUVFEZSyr75jG5ZJu2NXlda14qPjSKhuvFluJohmN+M5D37YCO4jlhzgDgW
        7fmOsUd9Z2DLZ7SHkVORxGr9iGtRDxw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-dI4Dm1W0O7K2Y7lhbei8QA-1; Tue, 21 Jun 2022 05:34:45 -0400
X-MC-Unique: dI4Dm1W0O7K2Y7lhbei8QA-1
Received: by mail-ed1-f72.google.com with SMTP id g8-20020a056402090800b00433940d207eso10600318edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=RWzQF61uANH2HUaxbmeM2TgavDsoShFLMy1+w4turxk=;
        b=u1Hb+R/qBfRh39AKFhabUIYkAs/mz2mLEkZKPUu2x5N2ul66ulSbYvtlrGeUz6iZgL
         AUjtV7Sseo4epqSno13OjJJeGzzegJJij1BJhDCj22XEZNQmzwLCUQTIBHAKPibDGp5g
         9nnLwZqjb9/XpWs740ZrF4P97K8/opL5U0JlQmZmDegzDJUePgMZObbTNVPgnTJPR9dy
         x35FMxjAA7kSOaOwNAjnwH3LYJDZa469GCKEia52KjK1Flr6dXi1UxxsGnPfoEjgDi51
         7lEQu8/WcLvjGTMwQb51vmLeZkI410Ur4MCPq02jb8siHyoziFSPlDNI9hsRqD0TWAcz
         PFZA==
X-Gm-Message-State: AJIora8lReNHL55WXll1W+5BZrCpz7cxNVA9GbHzL/QI0rH3YvAZt2yQ
        Hoq7lVMLbSL874X+OT9lmPrtyHi9OnUmXb/PHuVWlJbRuGB+AGXbVhK1+hUm9TWf+9m0mq6Jlw2
        d7xxutEoKipFIA5CGreC1325b
X-Received: by 2002:aa7:cf91:0:b0:435:6e07:2825 with SMTP id z17-20020aa7cf91000000b004356e072825mr19552757edx.381.1655804084277;
        Tue, 21 Jun 2022 02:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v++PB6fvCdw8ZAXMFkokVTJYFvG0ZbMrKc6wO7VzDohjdF8iJqgsXOFQbGziOaXlmbgHcN7w==
X-Received: by 2002:aa7:cf91:0:b0:435:6e07:2825 with SMTP id z17-20020aa7cf91000000b004356e072825mr19552739edx.381.1655804084110;
        Tue, 21 Jun 2022 02:34:44 -0700 (PDT)
Received: from ?IPV6:2001:1c01:2e0c:ab03:79ba:9443:520f:dd0a? (2001-1c01-2e0c-ab03-79ba-9443-520f-dd0a.cable.dynamic.v6.ziggo.nl. [2001:1c01:2e0c:ab03:79ba:9443:520f:dd0a])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b007121361d54asm7378726ejc.25.2022.06.21.02.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 02:34:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------qD2D9wuPhfF5xO8QnRCnE0e0"
Message-ID: <e5701e68-1b15-97b7-51e4-8d3c8a7c3c86@redhat.com>
Date:   Tue, 21 Jun 2022 11:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
Content-Language: en-US
To:     Kenneth Chan <kenneth.t.chan@gmail.com>
Cc:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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
 <CAPqSeKtqORkhW4dAMsd2b6e3OwhHZ107znwJtoBADE1h2-dsVA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPqSeKtqORkhW4dAMsd2b6e3OwhHZ107znwJtoBADE1h2-dsVA@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------qD2D9wuPhfF5xO8QnRCnE0e0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/20/22 17:21, Kenneth Chan wrote:
> It took quite a while to do a full compile, just to be safe.

<snip backlight stuff, which looks as expected>

> The mute, volume up/down keys are still duplicated by atkbd after
> applying 0005-platform-x86-panasonic-laptop-filter-out-duplicate-v.patch.

Hmm, can you add a couple of:

 pr_info("data 0x%02x\n", data);

at the top of the new panasonic_i8042_filter() function
and then check in dmesg what is output for the volume keys.

The patch should filter out those duplicate keys, unless
I got the codes wrong somehow.

Also can you please try the attached 2 patches on top of my
last series, this should hide the broken panasonic backlight
device and otherwise it should make no difference (but maybe
double check the duplicate brightness keys are not back.

Regards,

Hans
--------------qD2D9wuPhfF5xO8QnRCnE0e0
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
--------------qD2D9wuPhfF5xO8QnRCnE0e0
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

--------------qD2D9wuPhfF5xO8QnRCnE0e0--

