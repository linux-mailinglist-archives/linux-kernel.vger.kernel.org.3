Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843275AFD95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIGHdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIGHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88639A3D7E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662535971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6DdUIE615JVYQ/ZysdyIq2IvvKPpQqZflt2S56Y+Nic=;
        b=gx6ASlx/CSyYaP2Cjj6jihCzer1tePHlRQawzjR1m8iaDpi+9dmcYNzXMFL+kqoFefJsTi
        vzMpi4t+dd/5mZAXTyLiWs9LM3ICshNIPlqBMFUqxHPIKePGTWtP9LIaOol/eK751P2eK2
        ZsCr2xH4ppHUCGq0SchETa23xWrS3jg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-328-8qjBx_eMPCixcZs9_cMvAA-1; Wed, 07 Sep 2022 03:32:46 -0400
X-MC-Unique: 8qjBx_eMPCixcZs9_cMvAA-1
Received: by mail-ej1-f69.google.com with SMTP id qf22-20020a1709077f1600b00741638c5f3cso4570254ejc.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=6DdUIE615JVYQ/ZysdyIq2IvvKPpQqZflt2S56Y+Nic=;
        b=lRHlbocErmGldSsOI5Q8PYCo2kD0vCMldVDxZUZMks8LsvIMNUmit6ZRT21B+0aH8T
         30TFC2EJh5Lz6DYBAOwG/MWiSGNSyMyUA1fKZMPq3c0/cOCFMfPgSvhTV+Cmf3fuPaNF
         CzRUVKLyQpx3V19RHjO1/+GzwkoD8lW5pIGMI7qUQ482dVdiA/zwiRza9s6mGsbWXTpP
         nc5oJBgLPyqu+IFT96V/BV1MBBnS8PF/pufELmrL3C2/vkzUZ7gFSu89iiQVmdFw5wpF
         i4GTa0j7OfyJT1XVyIU2ittDT9YEl+zyYRsMTaY4/8tzRItIFGTw7FUzZoEtsAQqeSgL
         xucg==
X-Gm-Message-State: ACgBeo3jCwO/IQoRrxxR5ryemkB3MYe0P5S4L+/55RWjJGmwmpkkAVSh
        y95Do8ZAe3uMNzt4FRTtsjKcVvsf+1CGaaUJBvDMg0ir5AurlXkac3I0ubT7ZWrcddTghR9RVGB
        XCjeZNxyrK/LCr/xOwBnAchY6
X-Received: by 2002:a17:907:6e1a:b0:741:7b1e:f7b3 with SMTP id sd26-20020a1709076e1a00b007417b1ef7b3mr1389647ejc.303.1662535965215;
        Wed, 07 Sep 2022 00:32:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eHqxwUSBBNl3nW/5FnzevZiJ0uXGY3uFeraJT38epjV9KG/u9rhUH9jCztnuZmiEZtfJEsQ==
X-Received: by 2002:a17:907:6e1a:b0:741:7b1e:f7b3 with SMTP id sd26-20020a1709076e1a00b007417b1ef7b3mr1389627ejc.303.1662535965018;
        Wed, 07 Sep 2022 00:32:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s4-20020a50d484000000b004479cec6496sm10259815edi.75.2022.09.07.00.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:32:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------3a0baW9mzkGi50hBo6xVY0Up"
Message-ID: <5e446bfb-a45d-5146-7617-48d1d4798fee@redhat.com>
Date:   Wed, 7 Sep 2022 09:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
 <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
 <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
 <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3a0baW9mzkGi50hBo6xVY0Up
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/7/22 01:00, Andrew Cooper wrote:
> On 06/09/2022 22:00, Peter Zijlstra wrote:
>> On Tue, Sep 06, 2022 at 10:56:47PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 9/6/22 22:43, Peter Zijlstra wrote:
>>>> On Tue, Sep 06, 2022 at 10:17:43PM +0200, Hans de Goede wrote:
>>>>> On an Intel Atom N2600 (and presumable other Cedar Trail models)
>>>>> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
>>>>> by msr_build_context().
>>>>>
>>>>> This causes restore_processor_state() to try and restore it, but writing
>>>>> this MSR is not allowed on the Intel Atom N2600 leading to:
>>>> FWIW, virt tends to do this same thing a lot. They'll allow reading
>>>> random MSRs and only fail on write.
>>> Right. So I guess I should send a v2 with an updated commit
>>> message mentioning this ?
>> Nah, just saying this is a somewhat common pattern with MSRs.
>>
>> The best ones are the one where writing the value read is invalid :/ or
>> those who also silently eat a 0 write just for giggles. Luckily that
>> doesn't happen often.
> 
> Several comments.  First of all, MSR_TSX_CTRL is a fully read/write
> MSR.  If virt is doing this wrong, fix the hypervisor.  But this doesn't
> look virt related?
> 
> More importantly, MSR_TSX_CTRL does not plausibly exist on an Atom
> N2600, as it is more than a decade old.
> 
> MSR_TSX_CTRL was retrofitted in microcode to the MDS_NO, TAA-vulnerable
> CPUs which is a very narrow range from about 1 quarter of 2019 which
> includes Cascade Lake, and then included architecturally on subsequent
> parts which support TSX.
> 
> pm_save_spec_msr() is totally broken.  It's poking MSRs blindly without
> checking the enumeration of the capability first.

Note I did to a different version of this patch before this which did
add a capability check, but I only send that to various x86-folks +
x86@kernel.org which as Peter pointed out is an alias not a list,
so you will not have seen that earlier version.

I have attached the earlier version to this email.

> In this case, I bet the N2600 has a model specific MSR living at index
> 0x122 which has absolutely nothing at all to do with TSX.

That is my guess too.

Regards,

Hans
--------------3a0baW9mzkGi50hBo6xVY0Up
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-cpu-Avoid-writing-MSR_IA32_TSX_CTRL-when-tsx_ctr.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-cpu-Avoid-writing-MSR_IA32_TSX_CTRL-when-tsx_ctr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1MWJhYzJjNzM0ZTBmMmZkN2UyYWNiNDA2YWZkOGEyMDFkZGYzNDAwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUdWUsIDYgU2VwIDIwMjIgMTg6MDA6NDcgKzAyMDAKU3ViamVjdDogW1BB
VENIXSB4ODYvY3B1OiBBdm9pZCB3cml0aW5nIE1TUl9JQTMyX1RTWF9DVFJMIHdoZW4KICF0
c3hfY3RybF9pc19zdXBwb3J0ZWQoKQoKT24gYW4gSW50ZWwgQXRvbSBOMjYwMCAoYW5kIHBy
ZXN1bWFibGUgb3RoZXIgQ2VkYXIgVHJhaWwgbW9kZWxzKQpNU1JfSUEzMl9UU1hfQ1RSTCBj
YW4gYmUgcmVhZCwgY2F1c2luZyBzYXZlZF9tc3IudmFsaWQgdG8gYmUgc2V0IGZvciBpdApi
eSBtc3JfYnVpbGRfY29udGV4dCgpLgoKVGhpcyBjYXVzZXMgcmVzdG9yZV9wcm9jZXNzb3Jf
c3RhdGUoKSB0byB0cnkgYW5kIHJlc3RvcmUgaXQsIGJ1dCB3cml0aW5nCnRoaXMgTVNSIGlz
IG5vdCBhbGxvd2VkIG9uIHRoZSBJbnRlbCBBdG9tIE4yNjAwIGxlYWRpbmcgdG86CgpbICAg
OTkuOTU1MTQxXSB1bmNoZWNrZWQgTVNSIGFjY2VzcyBlcnJvcjogV1JNU1IgdG8gMHgxMjIg
KHRyaWVkIHRvIHdyaXRlIDB4MDAwMDAwMDAwMDAwMDAwMikgYXQgcklQOiAweGZmZmZmZmZm
OGIwN2E1NzQgKG5hdGl2ZV93cml0ZV9tc3IrMHg0LzB4MjApClsgICA5OS45NTUxNzZdIENh
bGwgVHJhY2U6ClsgICA5OS45NTUxODZdICA8VEFTSz4KWyAgIDk5Ljk1NTE5NV0gIHJlc3Rv
cmVfcHJvY2Vzc29yX3N0YXRlKzB4Mjc1LzB4MmMwClsgICA5OS45NTUyNDZdICB4ODZfYWNw
aV9zdXNwZW5kX2xvd2xldmVsKzB4MTBlLzB4MTQwClsgICA5OS45NTUyNzNdICBhY3BpX3N1
c3BlbmRfZW50ZXIrMHhkMy8weDEwMApbICAgOTkuOTU1Mjk3XSAgc3VzcGVuZF9kZXZpY2Vz
X2FuZF9lbnRlcisweDdlMi8weDgzMApbICAgOTkuOTU1MzQxXSAgcG1fc3VzcGVuZC5jb2xk
KzB4MmQyLzB4MzVlClsgICA5OS45NTUzNjhdICBzdGF0ZV9zdG9yZSsweDY4LzB4ZDAKWyAg
IDk5Ljk1NTQwMl0gIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDE1ZS8weDIxMApbICAgOTku
OTU1NDQyXSAgdmZzX3dyaXRlKzB4MjI1LzB4NGIwClsgICA5OS45NTU1MjNdICBrc3lzX3dy
aXRlKzB4NTkvMHhkMApbICAgOTkuOTU1NTU3XSAgZG9fc3lzY2FsbF82NCsweDU4LzB4ODAK
WyAgIDk5Ljk1NTU3OV0gID8gZG9fc3lzY2FsbF82NCsweDY3LzB4ODAKWyAgIDk5Ljk1NTYw
MF0gID8gdXBfcmVhZCsweDE3LzB4MjAKWyAgIDk5Ljk1NTYzMV0gID8gbG9ja19pc19oZWxk
X3R5cGUrMHhlMy8weDE0MApbICAgOTkuOTU1NjcwXSAgPyBhc21fZXhjX3BhZ2VfZmF1bHQr
MHgyMi8weDMwClsgICA5OS45NTU2ODhdICA/IGxvY2tkZXBfaGFyZGlycXNfb24rMHg3ZC8w
eDEwMApbICAgOTkuOTU1NzEwXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NjMvMHhjZApbICAgOTkuOTU1NzIzXSBSSVA6IDAwMzM6MHg3ZjdkMGZiMDE4ZjcKWyAgIDk5
Ljk1NTc0MV0gQ29kZTogMGYgMDAgZjcgZDggNjQgODkgMDIgNDggYzcgYzAgZmYgZmYgZmYg
ZmYgZWIgYjcgMGYgMWYgMDAgZjMgMGYgMWUgZmEgNjQgOGIgMDQgMjUgMTggMDAgMDAgMDAg
ODUgYzAgNzUgMTAgYjggMDEgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMCBmMCBmZiBmZiA3
NyA1MSBjMyA0OCA4MyBlYyAyOCA0OCA4OSA1NCAyNCAxOCA0OCA4OSA3NCAyNApbICAgOTku
OTU1NzUzXSBSU1A6IDAwMmI6MDAwMDdmZmQwMzI5MmVlOCBFRkxBR1M6IDAwMDAwMjQ2IE9S
SUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxClsgICA5OS45NTU3NzFdIFJBWDogZmZmZmZmZmZm
ZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDQgUkNYOiAwMDAwN2Y3ZDBmYjAxOGY3Clsg
ICA5OS45NTU3ODFdIFJEWDogMDAwMDAwMDAwMDAwMDAwNCBSU0k6IDAwMDA3ZmZkMDMyOTJm
ZDAgUkRJOiAwMDAwMDAwMDAwMDAwMDA0ClsgICA5OS45NTU3OTBdIFJCUDogMDAwMDdmZmQw
MzI5MmZkMCBSMDg6IDAwMDAwMDAwMDAwMGMwZmUgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClsg
ICA5OS45NTU3OTldIFIxMDogMDAwMDdmN2QwZmI4NWZiMCBSMTE6IDAwMDAwMDAwMDAwMDAy
NDYgUjEyOiAwMDAwMDAwMDAwMDAwMDA0ClsgICA5OS45NTU4MDhdIFIxMzogMDAwMDU1ZGY1
NjQxNzNlMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDQgUjE1OiAwMDAwN2Y3ZDBmYmY0OWUwClsg
ICA5OS45NTU5MTBdICA8L1RBU0s+CgpNYWtlIHRzeF9jdHJsX2lzX3N1cHBvcnRlZCgpIGZy
b20ga2VybmVsL2NwdS90c3guYyBub24gc3RhdGljIGFuZCBvbmx5IHBhc3MKcGFzcyBNU1Jf
SUEzMl9UU1hfQ1RSTCB0byBtc3JfYnVpbGRfY29udGV4dCgpIHdoZW4gdGhhdCByZXR1cm5z
IHRydWUuCgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgotLS0KSW1wb3J0YW50IG5vdGUgZm9yIHJldmlld2VyczogSW4gaXRzIGN1cnJlbnQg
Zm9ybSB0aGlzIHBhdGNoIGNoYW5nZXMgdGhlIG9yZGVyIGluCndoaWNoIE1TUi1zIGFyZSBy
ZXN0b3JlZCwgaXQgdXNlZCB0byBiZToKCiAgICAgICAgTVNSX0lBMzJfU1BFQ19DVFJMLAog
ICAgICAgIE1TUl9JQTMyX1RTWF9DVFJMLAogICAgICAgIE1TUl9UU1hfRk9SQ0VfQUJPUlQs
CiAgICAgICAgTVNSX0lBMzJfTUNVX09QVF9DVFJMLAogICAgICAgIE1TUl9BTUQ2NF9MU19D
RkcsCgpXaGljaCBpcyBub3cgY2hhbmdlZCB0bzoKCiAgICAgICAgTVNSX0lBMzJfU1BFQ19D
VFJMLAogICAgICAgIE1TUl9UU1hfRk9SQ0VfQUJPUlQsCiAgICAgICAgTVNSX0lBMzJfTUNV
X09QVF9DVFJMLAogICAgICAgIE1TUl9BTUQ2NF9MU19DRkcsCiAgICAgICAgTVNSX0lBMzJf
VFNYX0NUUkwsCgpJIGFtIG5vdCBzdXJlIGlmIHRoaXMgbWF5IGhhdmUgYW4gaW1wYWN0IG9u
IHRoZSB2YXJpb3VzIENQVQp2dWxuZXJhYmlsaXR5IG1pdGlnYXRpb25zLCBwbGVhc2UgcmV2
aWV3IGNhcmVmdWxseS4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHUuaCB8IDYgKysr
KysrCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L3RzeC5jICB8IDIgKy0KIGFyY2gveDg2L3Bvd2Vy
L2NwdS5jICAgICAgIHwgNCArKystCiAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
Y3B1LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHUuaAppbmRleCA4Y2JmNjIzZjBlY2Yu
LjkwNDc3MDFkMTk2NiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1LmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1LmgKQEAgLTQ5LDYgKzQ5LDcgQEAgZXh0
ZXJuIGJvb2wgaGFuZGxlX3VzZXJfc3BsaXRfbG9jayhzdHJ1Y3QgcHRfcmVncyAqcmVncywg
bG9uZyBlcnJvcl9jb2RlKTsKIGV4dGVybiBib29sIGhhbmRsZV9ndWVzdF9zcGxpdF9sb2Nr
KHVuc2lnbmVkIGxvbmcgaXApOwogZXh0ZXJuIHZvaWQgaGFuZGxlX2J1c19sb2NrKHN0cnVj
dCBwdF9yZWdzICpyZWdzKTsKIHU4IGdldF90aGlzX2h5YnJpZF9jcHVfdHlwZSh2b2lkKTsK
K2Jvb2wgdHN4X2N0cmxfaXNfc3VwcG9ydGVkKHZvaWQpOwogI2Vsc2UKIHN0YXRpYyBpbmxp
bmUgdm9pZCBfX2luaXQgc2xkX3NldHVwKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykge30KIHN0
YXRpYyBpbmxpbmUgYm9vbCBoYW5kbGVfdXNlcl9zcGxpdF9sb2NrKHN0cnVjdCBwdF9yZWdz
ICpyZWdzLCBsb25nIGVycm9yX2NvZGUpCkBAIC02Nyw2ICs2OCwxMSBAQCBzdGF0aWMgaW5s
aW5lIHU4IGdldF90aGlzX2h5YnJpZF9jcHVfdHlwZSh2b2lkKQogewogCXJldHVybiAwOwog
fQorCitzdGF0aWMgaW5saW5lIGJvb2wgdHN4X2N0cmxfaXNfc3VwcG9ydGVkKHZvaWQpCit7
CisJcmV0dXJuIGZhbHNlOworfQogI2VuZGlmCiAjaWZkZWYgQ09ORklHX0lBMzJfRkVBVF9D
VEwKIHZvaWQgaW5pdF9pYTMyX2ZlYXRfY3RsKHN0cnVjdCBjcHVpbmZvX3g4NiAqYyk7CmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RzeC5jIGIvYXJjaC94ODYva2VybmVs
L2NwdS90c3guYwppbmRleCBlYzdiYmFjM2E5ZjIuLmJlN2U4ZDRjYzBmYyAxMDA2NDQKLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS90c3guYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L3RzeC5jCkBAIC01OCw3ICs1OCw3IEBAIHN0YXRpYyB2b2lkIHRzeF9lbmFibGUodm9pZCkK
IAl3cm1zcmwoTVNSX0lBMzJfVFNYX0NUUkwsIHRzeCk7CiB9CiAKLXN0YXRpYyBib29sIHRz
eF9jdHJsX2lzX3N1cHBvcnRlZCh2b2lkKQorYm9vbCB0c3hfY3RybF9pc19zdXBwb3J0ZWQo
dm9pZCkKIHsKIAl1NjQgaWEzMl9jYXAgPSB4ODZfcmVhZF9hcmNoX2NhcF9tc3IoKTsKIApk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvcG93ZXIvY3B1LmMgYi9hcmNoL3g4Ni9wb3dlci9jcHUu
YwppbmRleCBiYjE3NmM3Mjg5MWMuLjljOTUwOTlkMWFkZCAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvcG93ZXIvY3B1LmMKKysrIGIvYXJjaC94ODYvcG93ZXIvY3B1LmMKQEAgLTUxNSwxMyAr
NTE1LDE1IEBAIHN0YXRpYyB2b2lkIHBtX3NhdmVfc3BlY19tc3Iodm9pZCkKIHsKIAl1MzIg
c3BlY19tc3JfaWRbXSA9IHsKIAkJTVNSX0lBMzJfU1BFQ19DVFJMLAotCQlNU1JfSUEzMl9U
U1hfQ1RSTCwKIAkJTVNSX1RTWF9GT1JDRV9BQk9SVCwKIAkJTVNSX0lBMzJfTUNVX09QVF9D
VFJMLAogCQlNU1JfQU1ENjRfTFNfQ0ZHLAogCX07CisJdTMyIHRzeF9jdHJsX21zcl9pZFtd
ID0geyBNU1JfSUEzMl9UU1hfQ1RSTCB9OwogCiAJbXNyX2J1aWxkX2NvbnRleHQoc3BlY19t
c3JfaWQsIEFSUkFZX1NJWkUoc3BlY19tc3JfaWQpKTsKKwlpZiAodHN4X2N0cmxfaXNfc3Vw
cG9ydGVkKCkpCisJCW1zcl9idWlsZF9jb250ZXh0KHRzeF9jdHJsX21zcl9pZCwgQVJSQVlf
U0laRSh0c3hfY3RybF9tc3JfaWQpKTsKIH0KIAogc3RhdGljIGludCBwbV9jaGVja19zYXZl
X21zcih2b2lkKQotLSAKMi4zNy4yCgo=

--------------3a0baW9mzkGi50hBo6xVY0Up--

