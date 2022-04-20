Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70895508DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380796AbiDTRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDTRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:03:31 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1B20BC9;
        Wed, 20 Apr 2022 10:00:42 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 44C2F3F805;
        Wed, 20 Apr 2022 19:00:39 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------WPJK0mzTbAcohIQgdAMyc7W3"
Message-ID: <997f91b9-c22e-41f0-300b-92559bc7896e@somainline.org>
Date:   Wed, 20 Apr 2022 19:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sm8350-sagami: usb qmp phy node
 - add 'vdda-pll-supply' & 'vdda-phy-supply'
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, bjorn.andersson@linaro.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------WPJK0mzTbAcohIQgdAMyc7W3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/04/2022 22:58, Bhupesh Sharma wrote:
> As suggested by Bjorn during review of [1], the 'vdda-pll-supply' &
> 'vdda-phy-supply' supplies denote the power for the bus and the
> clock of the usb qmp phy and are used by the qcom qmp phy driver.
>
> So, its safe to assume that the two regulators are the same as on
> the MTP. So let's wire them up in the same way as the MTP.
>
> In absence of the same 'make dtbs_check' leads to following warnings:
>
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>   phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
>
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>   phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
>
> [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: konrad.dybcio@somainline.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> Changes since v1:
> -----------------
> - v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg108467.html
> - Fixed the commit message to read usb qmp phy instead of ufs phy (which
>    was introduced erroraneously in the commit log).
>
>   .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)

Hi, I actually threw together a patch with [almost] all RPMh regulators 
on Sagami quite a while ago (if thunderbird doesn't explode, you should 
find it as an attachment to this message), but I haven't sent it, as 
pm8350c_l3 and pmr735a_s3 are broken on the .c driver side (the step 
numbers and/or values are not correct), but Qualcomm in their infinite 
Qualcommery will not let us, mere mortals, access the PDFs that contain 
the correct specifications, so I have to wait for somebody with access 
to them to pick them up. That said, the values you supplied seem correct 
(say for lack of allow-set-load which will bite when (if?) UFS is ever 
functional upstream on this piece of Japanese engineering), but adding 
the configuration of all regulators at once just seems more complete to me..


On a note, USB - among other more or less necessary peripherals - along 
with its supplies, is brought up in XBL (or bootrom if you jump to EDL), 
so not setting these supplies in Linux does not bite in any way, shape 
or form other than "make dtbs_check" screaming.


I'm not against this patch, but once again, even though this point may 
not sound very convincing to you all, I think it would be "nice" to 
configure all regulators in one go.


Konrad


> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index 90b13cbe2fa6..238ac9380ca2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
>    */
>   
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sm8350.dtsi"
>   #include "pm8350.dtsi"
>   #include "pm8350b.dtsi"
> @@ -75,6 +76,27 @@ ramoops@ffc00000 {
>   	};
>   };
>   
> +&apps_rsc {
> +	pm8350-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vreg_l1b_0p88: ldo1 {
> +			regulator-name = "vreg_l1b_0p88";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p2: ldo6 {
> +			regulator-name = "vreg_l6b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
>   &adsp {
>   	status = "okay";
>   	firmware-name = "qcom/adsp.mbn";
> @@ -256,4 +278,7 @@ &usb_1_hsphy {
>   
>   &usb_1_qmpphy {
>   	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p88>;
>   };
--------------WPJK0mzTbAcohIQgdAMyc7W3
Content-Type: text/plain; charset=UTF-8; name="sagami_regulators.patch"
Content-Disposition: attachment; filename="sagami_regulators.patch"
Content-Transfer-Encoding: base64

RnJvbSBkYTIwYzJhZmEyYzA3MTVlZjc4MTM2Y2Q2NzBlZTljMWRiM2FkZjZjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLb25yYWQgRHliY2lvIDxrb25yYWQuZHliY2lvQHNv
bWFpbmxpbmUub3JnPgpEYXRlOiBTYXQsIDUgTWFyIDIwMjIgMTc6MDg6NTggKzAxMDAKU3Vi
amVjdDogW1BBVENIXSBhcm02NDogZHRzOiBxY29tOiBzbTgzNTAtc2FnYW1pOiBBZGQgbW9z
dCBSUE1oIHJlZ3VsYXRvcnMKCkNvbmZpZ3VyZSBtb3N0IFJQTWgtY29udHJvbGxlZCByZWd1
bGF0b3JzIG9uIFNvTUMgU2FnYW1pLiBUaGUgbWlzc2luZwpvbmVzIChvbiBwbTgzNTBiIGFu
ZCBwbTgwMDhbaWpdKSB3aWxsIGJlIGNvbmZpZ3VyZWQgd2hlbiBkcml2ZXIgc3VwcG9ydApp
cyBhZGRlZC4gVGhhbmtmdWxseSwgaXQgbG9va3MgbGlrZSBQRFgyMTUgYW5kIFBEWDIxNCBk
b24ndCBoYXZlIGFueQpkaWZmZXJlbmNlcyB3aGVuIGl0IGNvbWVzIHRvIFBNODM1MC9QTTgz
NTBDL1BNUjczNWEuCgpTaWduZWQtb2ZmLWJ5OiBLb25yYWQgRHliY2lvIDxrb25yYWQuZHli
Y2lvQHNvbWFpbmxpbmUub3JnPgotLS0KIC4uLi9kdHMvcWNvbS9zbTgzNTAtc29ueS14cGVy
aWEtc2FnYW1pLmR0c2kgICB8IDM1MCArKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAzNTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9zbTgzNTAtc29ueS14cGVyaWEtc2FnYW1pLmR0c2kgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL3Fjb20vc204MzUwLXNvbnkteHBlcmlhLXNhZ2FtaS5kdHNpCmluZGV4IDkwYjEz
Y2JlMmZhNjMuLjgxMzYzZjM2N2Q0NTIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9zbTgzNTAtc29ueS14cGVyaWEtc2FnYW1pLmR0c2kKKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9xY29tL3NtODM1MC1zb255LXhwZXJpYS1zYWdhbWkuZHRzaQpAQCAtMyw2
ICszLDcgQEAKICAqIENvcHlyaWdodCAoYykgMjAyMSwgS29ucmFkIER5YmNpbyA8a29ucmFk
LmR5YmNpb0Bzb21haW5saW5lLm9yZz4KICAqLwogCisjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cmVndWxhdG9yL3Fjb20scnBtaC1yZWd1bGF0b3IuaD4KICNpbmNsdWRlICJzbTgzNTAuZHRz
aSIKICNpbmNsdWRlICJwbTgzNTAuZHRzaSIKICNpbmNsdWRlICJwbTgzNTBiLmR0c2kiCkBA
IC03Myw2ICs3NCwxNiBAQAogCQkJbm8tbWFwOwogCQl9OwogCX07CisKKwl2cGhfcHdyOiB2
cGgtcHdyLXJlZ3VsYXRvciB7CisJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsK
KwkJcmVndWxhdG9yLW5hbWUgPSAidnBoX3B3ciI7CisJCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDM3MDAwMDA+OworCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzNzAwMDAw
PjsKKworCQlyZWd1bGF0b3ItYWx3YXlzLW9uOworCQlyZWd1bGF0b3ItYm9vdC1vbjsKKwl9
OwogfTsKIAogJmFkc3AgewpAQCAtODAsNiArOTEsMzQ1IEBACiAJZmlybXdhcmUtbmFtZSA9
ICJxY29tL2Fkc3AubWJuIjsKIH07CiAKKyZhcHBzX3JzYyB7CisJcG04MzUwLXJwbWgtcmVn
dWxhdG9ycyB7CisJCWNvbXBhdGlibGUgPSAicWNvbSxwbTgzNTAtcnBtaC1yZWd1bGF0b3Jz
IjsKKwkJcWNvbSxwbWljLWlkID0gImIiOworCisJCXZkZC1zMS1zdXBwbHkgPSA8JnZwaF9w
d3I+OworCQl2ZGQtczItc3VwcGx5ID0gPCZ2cGhfcHdyPjsKKwkJdmRkLXMzLXN1cHBseSA9
IDwmdnBoX3B3cj47CisJCXZkZC1zNC1zdXBwbHkgPSA8JnZwaF9wd3I+OworCQl2ZGQtczUt
c3VwcGx5ID0gPCZ2cGhfcHdyPjsKKwkJdmRkLXM2LXN1cHBseSA9IDwmdnBoX3B3cj47CisJ
CXZkZC1zNy1zdXBwbHkgPSA8JnZwaF9wd3I+OworCQl2ZGQtczgtc3VwcGx5ID0gPCZ2cGhf
cHdyPjsKKwkJdmRkLXM5LXN1cHBseSA9IDwmdnBoX3B3cj47CisJCXZkZC1zMTAtc3VwcGx5
ID0gPCZ2cGhfcHdyPjsKKwkJdmRkLXMxMS1zdXBwbHkgPSA8JnZwaF9wd3I+OworCQl2ZGQt
czEyLXN1cHBseSA9IDwmdnBoX3B3cj47CisKKwkJdmRkLWwxLWw0LXN1cHBseSA9IDwmcG04
MzUwX3MxMT47CisJCXZkZC1sMi1sNy1zdXBwbHkgPSA8JnZyZWdfYm9iPjsKKwkJdmRkLWwz
LWw1LXN1cHBseSA9IDwmdnJlZ19ib2I+OworCQl2ZGQtbDYtbDktbDEwLXN1cHBseSA9IDwm
cG04MzUwX3MxMT47CisKKwkJLyoKKwkJICogQVJDIHJlZ3VsYXRvcnM6CisJCSAqIFM1IC0g
bXgubHZsCisJCSAqIFM2IC0gZ2Z4Lmx2bAorCQkgKiBTOSAtIG14Yy5sdmwKKwkJICovCisK
KwkJcG04MzUwX3MxMDogc21wczEwIHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtODM1MF9z
MTAiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47CisJCQlyZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFs
LW1vZGUgPSA8UlBNSF9SRUdVTEFUT1JfTU9ERV9IUE0+OworCQl9OworCisJCXBtODM1MF9z
MTE6IHNtcHMxMSB7CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJwbTgzNTBfczExIjsKKwkJCXJl
Z3VsYXRvci1taW4tbWljcm92b2x0ID0gPDc1MjAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1p
Y3Jvdm9sdCA9IDwxMDAwMDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFsLW1vZGUgPSA8UlBN
SF9SRUdVTEFUT1JfTU9ERV9IUE0+OworCQl9OworCisJCXBtODM1MF9zMTI6IHNtcHMxMiB7
CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJwbTgzNTBfczEyIjsKKwkJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDEyMjQwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8
MTM2MDAwMD47CisJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9S
X01PREVfSFBNPjsKKwkJfTsKKworCQlwbTgzNTBfbDE6IGxkbzEgeworCQkJcmVndWxhdG9y
LW5hbWUgPSAicG04MzUwX2wxIjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDkx
MjAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw5MjAwMDA+OworCQkJcmVn
dWxhdG9yLWluaXRpYWwtbW9kZSA9IDxSUE1IX1JFR1VMQVRPUl9NT0RFX0hQTT47CisJCX07
CisKKwkJcG04MzUwX2wyOiBsZG8yIHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtODM1MF9s
MiI7CisJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMDcyMDAwPjsKKwkJCXJlZ3Vs
YXRvci1tYXgtbWljcm92b2x0ID0gPDMwNzIwMDA+OworCQkJcmVndWxhdG9yLWluaXRpYWwt
bW9kZSA9IDxSUE1IX1JFR1VMQVRPUl9NT0RFX0hQTT47CisJCX07CisKKwkJcG04MzUwX2wz
OiBsZG8zIHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtODM1MF9sMyI7CisJCQlyZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDw5MDQwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3Zv
bHQgPSA8OTA0MDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFsLW1vZGUgPSA8UlBNSF9SRUdV
TEFUT1JfTU9ERV9IUE0+OworCQl9OworCisJCS8qIEw0IC0gbG14Lmx2bCAoQVJDKSAqLwor
CisJCXBtODM1MF9sNTogbGRvNSB7CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJwbTgzNTBfbDUi
OworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODgwMDAwPjsKKwkJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDg4ODAwMD47CisJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2Rl
ID0gPFJQTUhfUkVHVUxBVE9SX01PREVfSFBNPjsKKwkJCXJlZ3VsYXRvci1hbGxvdy1zZXQt
bG9hZDsKKwkJfTsKKworCQlwbTgzNTBfbDY6IGxkbzYgeworCQkJcmVndWxhdG9yLW5hbWUg
PSAicG04MzUwX2w2IjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDEyMDAwMDA+
OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTIwODAwMD47CisJCQlyZWd1bGF0
b3ItaW5pdGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9SX01PREVfSFBNPjsKKwkJCXJlZ3Vs
YXRvci1hbGxvdy1zZXQtbG9hZDsKKwkJfTsKKworCQlwbTgzNTBfbDc6IGxkbzcgeworCQkJ
cmVndWxhdG9yLW5hbWUgPSAicG04MzUwX2w3IjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDI0MDAwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzAwODAw
MD47CisJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9SX01PREVf
SFBNPjsKKwkJCXJlZ3VsYXRvci1hbGxvdy1zZXQtbG9hZDsKKwkJfTsKKworCQkvKiBMOCAt
IGxjeC5sdmwgKEFSQykgKi8KKworCQlwbTgzNTBfbDk6IGxkbzkgeworCQkJcmVndWxhdG9y
LW5hbWUgPSAicG04MzUwX2w5IjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDEy
MDAwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTIwMDAwMD47CisJCQly
ZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9SX01PREVfSFBNPjsKKwkJ
CXJlZ3VsYXRvci1hbGxvdy1zZXQtbG9hZDsKKwkJfTsKKwl9OworCisJcG04MzUwYy1ycG1o
LXJlZ3VsYXRvcnMgeworCQljb21wYXRpYmxlID0gInFjb20scG04MzUwYy1ycG1oLXJlZ3Vs
YXRvcnMiOworCQlxY29tLHBtaWMtaWQgPSAiYyI7CisKKwkJdmRkLXMxLXN1cHBseSA9IDwm
dnBoX3B3cj47CisJCXZkZC1zMi1zdXBwbHkgPSA8JnZwaF9wd3I+OworCQl2ZGQtczMtc3Vw
cGx5ID0gPCZ2cGhfcHdyPjsKKwkJdmRkLXM0LXN1cHBseSA9IDwmdnBoX3B3cj47CisJCXZk
ZC1zNS1zdXBwbHkgPSA8JnZwaF9wd3I+OworCQl2ZGQtczYtc3VwcGx5ID0gPCZ2cGhfcHdy
PjsKKwkJdmRkLXM3LXN1cHBseSA9IDwmdnBoX3B3cj47CisJCXZkZC1zOC1zdXBwbHkgPSA8
JnZwaF9wd3I+OworCQl2ZGQtczktc3VwcGx5ID0gPCZ2cGhfcHdyPjsKKwkJdmRkLXMxMC1z
dXBwbHkgPSA8JnZwaF9wd3I+OworCisJCXZkZC1sMS1sMTItc3VwcGx5ID0gPCZwbTgzNTBj
X3MxPjsKKwkJdmRkLWwyLWw4LXN1cHBseSA9IDwmcG04MzUwY19zMT47CisJCXZkZC1sMy1s
NC1sNS1sNy1sMTMtc3VwcGx5ID0gPCZ2cmVnX2JvYj47CisJCXZkZC1sNi1sOS1sMTEtc3Vw
cGx5ID0gPCZ2cmVnX2JvYj47CisJCXZkZC1sMTAtc3VwcGx5ID0gPCZwbTgzNTBfczEyPjsK
KworCQl2ZGQtYm9iLXN1cHBseSA9IDwmdnBoX3B3cj47CisKKwkJcG04MzUwY19zMTogc21w
czEgeworCQkJcmVndWxhdG9yLW5hbWUgPSAicG04MzUwY19zMSI7CisJCQlyZWd1bGF0b3It
bWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0
ID0gPDE5NTIwMDA+OworCQkJcmVndWxhdG9yLWluaXRpYWwtbW9kZSA9IDxSUE1IX1JFR1VM
QVRPUl9NT0RFX0hQTT47CisJCX07CisKKwkJLyogUzIgLSBlYmkubHZsIChBUkMpICovCisK
KwkJcG04MzUwY19zMzogc21wczMgeworCQkJcmVndWxhdG9yLW5hbWUgPSAicG04MzUwY19z
MyI7CisJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMDAwMDA+OworCQkJcmVndWxh
dG9yLW1heC1taWNyb3ZvbHQgPSA8NzA0MDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFsLW1v
ZGUgPSA8UlBNSF9SRUdVTEFUT1JfTU9ERV9IUE0+OworCQl9OworCisJCS8qCisJCSAqIEFS
QyByZWd1bGF0b3JzOgorCQkgKiBTNCAtIG1zcy5sdmwKKwkJICogUzYgLSBjeC5sdmwKKwkJ
ICogUzggLSBtbWN4Lmx2bAorCQkgKi8KKworCQlwbTgzNTBjX3MxMDogc21wczEwIHsKKwkJ
CXJlZ3VsYXRvci1uYW1lID0gInBtODM1MGNfczEwIjsKKwkJCXJlZ3VsYXRvci1taW4tbWlj
cm92b2x0ID0gPDEwNDgwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTEy
ODAwMD47CisJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9SX01P
REVfSFBNPjsKKwkJfTsKKworCQlwbTgzNTBjX2wxOiBsZG8xIHsKKwkJCXJlZ3VsYXRvci1u
YW1lID0gInBtODM1MGNfbDEiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgw
MDAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCXJl
Z3VsYXRvci1pbml0aWFsLW1vZGUgPSA8UlBNSF9SRUdVTEFUT1JfTU9ERV9IUE0+OworCQl9
OworCisJCXBtODM1MGNfbDI6IGxkbzIgeworCQkJcmVndWxhdG9yLW5hbWUgPSAicG04MzUw
Y19sMiI7CisJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE4MDAwMDA+OworCQkJcmVndWxhdG9yLWluaXRp
YWwtbW9kZSA9IDxSUE1IX1JFR1VMQVRPUl9NT0RFX0hQTT47CisJCX07CisKKwkJcG04MzUw
Y19sMzogbGRvMyB7CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJwbTgzNTBjX2wzIjsKKwkJCXJl
Z3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+OworCQkJcmVndWxhdG9yLW1heC1t
aWNyb3ZvbHQgPSA8MzMwMDAwMD47CisJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQ
TUhfUkVHVUxBVE9SX01PREVfSFBNPjsKKwkJfTsKKworCQlwbTgzNTBjX2w0OiBsZG80IHsK
KwkJCXJlZ3VsYXRvci1uYW1lID0gInBtODM1MGNfbDQiOworCQkJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8MTcwNDAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwz
MDAwMDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFsLW1vZGUgPSA8UlBNSF9SRUdVTEFUT1Jf
TU9ERV9IUE0+OworCQl9OworCisJCXBtODM1MGNfbDU6IGxkbzUgeworCQkJcmVndWxhdG9y
LW5hbWUgPSAicG04MzUwY19sNSI7CisJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwx
NzA0MDAwPjsKKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMwMDAwMDA+OworCQkJ
cmVndWxhdG9yLWluaXRpYWwtbW9kZSA9IDxSUE1IX1JFR1VMQVRPUl9NT0RFX0hQTT47CisJ
CX07CisKKwkJcG04MzUwY19sNjogbGRvNiB7CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJwbTgz
NTBjX2w2IjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+OworCQkJ
cmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8Mjk2MDAwMD47CisJCQlyZWd1bGF0b3ItaW5p
dGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9SX01PREVfSFBNPjsKKwkJfTsKKworCQlwbTgz
NTBjX2w3OiBsZG83IHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtODM1MGNfbDciOworCQkJ
cmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzAwODAwMD47CisJCQlyZWd1bGF0b3ItbWF4
LW1pY3Jvdm9sdCA9IDwzMDA4MDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFsLW1vZGUgPSA8
UlBNSF9SRUdVTEFUT1JfTU9ERV9IUE0+OworCQl9OworCisJCXBtODM1MGNfbDg6IGxkbzgg
eworCQkJcmVndWxhdG9yLW5hbWUgPSAicG04MzUwY19sOCI7CisJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0g
PDE4MDAwMDA+OworCQkJcmVndWxhdG9yLWluaXRpYWwtbW9kZSA9IDxSUE1IX1JFR1VMQVRP
Ul9NT0RFX0hQTT47CisJCX07CisKKwkJcG04MzUwY19sOTogbGRvOSB7CisJCQlyZWd1bGF0
b3ItbmFtZSA9ICJwbTgzNTBjX2w5IjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0g
PDI5NjAwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzAwODAwMD47CisJ
CQlyZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQTUhfUkVHVUxBVE9SX01PREVfSFBNPjsK
KwkJfTsKKworCQlwbTgzNTBjX2wxMDogbGRvMTAgeworCQkJcmVndWxhdG9yLW5hbWUgPSAi
cG04MzUwY19sMTAiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTIwMDAwMD47
CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMjAwMDAwPjsKKwkJCXJlZ3VsYXRv
ci1pbml0aWFsLW1vZGUgPSA8UlBNSF9SRUdVTEFUT1JfTU9ERV9IUE0+OworCQl9OworCisJ
CXBtODM1MGNfbDExOiBsZG8xMSB7CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJwbTgzNTBjX2wx
MSI7CisJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyNDAwMDAwPjsKKwkJCXJlZ3Vs
YXRvci1tYXgtbWljcm92b2x0ID0gPDMwMDgwMDA+OworCQkJcmVndWxhdG9yLWluaXRpYWwt
bW9kZSA9IDxSUE1IX1JFR1VMQVRPUl9NT0RFX0hQTT47CisJCX07CisKKwkJcG04MzUwY19s
MTI6IGxkbzEyIHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtODM1MGNfbDEyIjsKKwkJCXJl
Z3VsYXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+OworCQkJcmVndWxhdG9yLW1heC1t
aWNyb3ZvbHQgPSA8MjAwMDAwMD47CisJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2RlID0gPFJQ
TUhfUkVHVUxBVE9SX01PREVfSFBNPjsKKwkJfTsKKworCQlwbTgzNTBjX2wxMzogbGRvMTMg
eworCQkJcmVndWxhdG9yLW5hbWUgPSAicG04MzUwY19sMTMiOworCQkJcmVndWxhdG9yLW1p
bi1taWNyb3ZvbHQgPSA8MzAwMDAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9
IDwzMDAwMDAwPjsKKwkJCXJlZ3VsYXRvci1pbml0aWFsLW1vZGUgPSA8UlBNSF9SRUdVTEFU
T1JfTU9ERV9IUE0+OworCQl9OworCisJCXZyZWdfYm9iOiBib2IgeworCQkJcmVndWxhdG9y
LW5hbWUgPSAidnJlZ19ib2IiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzQw
MDAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzOTYwMDAwPjsKKwkJCXJl
Z3VsYXRvci1pbml0aWFsLW1vZGUgPSA8UlBNSF9SRUdVTEFUT1JfTU9ERV9BVVRPPjsKKwkJ
fTsKKwl9OworCisJLyogVE9ETzogQWRkIHBtODM1MGIgKGp1c3Qgb25lIGxkbykgb25jZSB0
aGUgZHJpdmVyIHBhcnQgaXMgaW4gKi8KKworCXBtcjczNWEtcnBtaC1yZWd1bGF0b3JzIHsK
KwkJY29tcGF0aWJsZSA9ICJxY29tLHBtcjczNWEtcnBtaC1yZWd1bGF0b3JzIjsKKwkJcWNv
bSxwbWljLWlkID0gImUiOworCisJCXZkZC1zMS1zdXBwbHkgPSA8JnZwaF9wd3I+OworCQl2
ZGQtczItc3VwcGx5ID0gPCZ2cGhfcHdyPjsKKwkJdmRkLXMzLXN1cHBseSA9IDwmdnBoX3B3
cj47CisKKwkJdmRkLWwxLWwyLXN1cHBseSA9IDwmcG1yNzM1YV9zMj47CisJCXZkZC1sMy1z
dXBwbHkgPSA8JnBtcjczNWFfczE+OworCQl2ZGQtbDQtc3VwcGx5ID0gPCZwbTgzNTBjX3Mx
PjsKKwkJdmRkLWw1LWw2LXN1cHBseSA9IDwmcG04MzUwY19zMT47CisJCXZkZC1sNy1ib2It
c3VwcGx5ID0gPCZ2cmVnX2JvYj47CisKKwkJcG1yNzM1YV9zMTogc21wczEgeworCQkJcmVn
dWxhdG9yLW5hbWUgPSAicG1yNzM1YV9zMSI7CisJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDwxMjAwMDAwPjsKKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDEyODAwMDA+
OworCQl9OworCisJCXBtcjczNWFfczI6IHNtcHMyIHsKKwkJCXJlZ3VsYXRvci1uYW1lID0g
InBtcjczNWFfczIiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NTAwMDAwPjsK
KwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDk3NjAwMD47CisJCX07CisKKwkJcG1y
NzM1YV9zMzogc21wczMgeworCQkJcmVndWxhdG9yLW5hbWUgPSAicG1yNzM1YV9zMyI7CisJ
CQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyMjAwMDAwPjsKKwkJCXJlZ3VsYXRvci1t
YXgtbWljcm92b2x0ID0gPDIzNTIwMDA+OworCQl9OworCisJCXBtcjczNWFfbDE6IGxkbzEg
eworCQkJcmVndWxhdG9yLW5hbWUgPSAicG1yNzM1YV9sMSI7CisJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDw5MTIwMDA+OworCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8
OTEyMDAwPjsKKwkJfTsKKworCQlwbXI3MzVhX2wyOiBsZG8yIHsKKwkJCXJlZ3VsYXRvci1u
YW1lID0gInBtcjczNWFfbDIiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTIw
MDAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMjAwMDAwPjsKKwkJfTsK
KworCQlwbXI3MzVhX2wzOiBsZG8zIHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtcjczNWFf
bDMiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTIwMDAwMD47CisJCQlyZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMjAwMDAwPjsKKwkJfTsKKworCQlwbXI3MzVhX2w0
OiBsZG80IHsKKwkJCXJlZ3VsYXRvci1uYW1lID0gInBtcjczNWFfbDQiOworCQkJcmVndWxh
dG9yLW1pbi1taWNyb3ZvbHQgPSA8MTc3NjAwMD47CisJCQlyZWd1bGF0b3ItbWF4LW1pY3Jv
dm9sdCA9IDwxODcyMDAwPjsKKwkJfTsKKworCQlwbXI3MzVhX2w1OiBsZG81IHsKKwkJCXJl
Z3VsYXRvci1uYW1lID0gInBtcjczNWFfbDUiOworCQkJcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8ODAwMDAwPjsKKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDgwMDAwMD47
CisJCX07CisKKwkJcG1yNzM1YV9sNjogbGRvNiB7CisJCQlyZWd1bGF0b3ItbmFtZSA9ICJw
bXI3MzVhX2w2IjsKKwkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDQ4MDAwMD47CisJ
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw5MDQwMDA+OworCQl9OworCisJCXBtcjcz
NWFfbDc6IGxkbzcgeworCQkJcmVndWxhdG9yLW5hbWUgPSAicG1yNzM1YV9sNyI7CisJCQly
ZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyODAwMDAwPjsKKwkJCXJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDI4MDAwMDA+OworCQl9OworCX07Cit9OworCiAmY2RzcCB7CiAJc3Rh
dHVzID0gIm9rYXkiOwogCWZpcm13YXJlLW5hbWUgPSAicWNvbS9jZHNwLm1ibiI7Cg==

--------------WPJK0mzTbAcohIQgdAMyc7W3--
